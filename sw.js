const cacheName = 'api-portal-v3';
const staticAssets = [
    './'
];
self.addEventListener('install', async event => {
    //console.log('install event');
    const cache = await caches.open(cacheName);
    await cache.addAll(staticAssets);
});

self.addEventListener('fetch', async event => {
    //console.log('fetch event');
    const req = event.request;
    //event.respondWith(cacheFirst(req));
    //event.respondWith(networkFirst(req));
    if (/.*(json)$/.test(req.url)) {
        event.respondWith(networkFirst(req));
    } else {
        event.respondWith(cacheFirst(req));
    }
    //indexedDB
    // every request from our site, passes through the fetch handler
    // I have proof
   /* console.log('I am a request with url: ', event.request.clone().url);
    console.log(event);
    if (event.request.clone().method === 'GET') {
        event.respondWith(
            // check all the caches in the browser and find
            // out whether our request is in any of them
            caches.match(event.request.clone())
                .then(function (response) {
                        if (response) {
                            // if we are here, that means there's a match
                            //return the response stored in browser
                            console.log(response);
                            return response;
                        }
                        // no match in cache, use the network instead
                        return fetch(event.request.clone());
                    }
                )
        );
    } else if (event.request.clone().method === 'PUT') {
       // console.log( form_data);
        // attempt to send request normally
        event.respondWith(fetch(event.request.clone()).catch(function
            (error) {
            // only save post requests in browser, if an error occurs
            savePostRequests(event.request.clone().url, form_data)
        }))
    }*/
});

async function cacheFirst(req) {
    const cache = await caches.open(cacheName);
    const cachedResponse = await cache.match(req);
    //return cachedResponse || fetch(req);
    return cachedResponse || networkFirst(req);
}

async function networkFirst(req) {
    const cache = await caches.open(cacheName);
    try {
        const fresh = await fetch(req);
        cache.put(req, fresh.clone());
        return fresh;
    } catch (e) {
        const cachedResponse = await cache.match(req);
        return cachedResponse;
    }
}

//indexedDb
var our_db;

function openDatabase() {
    //var indexedDBOpenRequest = indexedDB.open('flask-form', IDBDatabase.version);
    var indexedDBOpenRequest = indexedDB.open('clients_form', 3);
    indexedDBOpenRequest.onerror = function (error) {
        console.error('IndexedDB error:', error)
    };
    indexedDBOpenRequest.onupgradeneeded = function () {
        this.result.createObjectStore('post_requests', {autoIncrement: true, keyPath: 'id'})
    };
    indexedDBOpenRequest.onsuccess = function () {
        our_db = this.result;
    }
}

openDatabase();

self.addEventListener('message', function (event) {
    console.log('form data', event.data);
    if (event.data.hasOwnProperty('form_data')) {
        // receives form data from script.js upon submission
         form_data = event.data.form_data;
    }
});

function getObjectStore(storeName, mode) {
    // retrieve our object store
    return our_db.transaction(storeName, mode).objectStore(storeName)
}

function savePostRequests(url, payload) {
    // get object_store and save our payload inside it
    var request = getObjectStore('post_requests', 'readwrite').add({
        url: url,
        payload: payload,
        method: 'POST'
    });
    request.onsuccess = function (event) {
        console.log('a new pos_ request has been added to indexedb')
    };
    request.onerror = function (error) {
        console.error(error)
    }
}
