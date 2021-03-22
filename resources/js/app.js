/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

//Import View Router
//import VueRouter from 'vue-router';

//Vue.use(VueRouter);

import axios from 'axios';

const token = localStorage.getItem('token');
if (token) {
    axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
}
/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

//Vue.component('example-component', require('./components/ExampleComponent.vue').default);

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
//Routes
import router from './routes';
//import {routes} from './routes';

//Register Routes
/*const router = new VueRouter({
    routes,
    mode: 'hash',
});*/
/*router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (store.getters.isLoggedIn) {
            next();
            return
        }
        next('/login')
    } else {
        next()
    }
});*/

/*import 'devextreme/dist/css/dx.common.css';
import 'devextreme/dist/css/dx.light.css';*/

import App from './components/App';
import store from "./store";
// This is a global mixin, it is applied to every vue instance
Vue.mixin({
    data() {
        return {
            // base_url: base_url
        }
    }
});

new Vue({
    el: '#app',
    router,
    store,
    render: h => h(App),
    mounted: function () {
        if (store.getters.isLoggedIn) {
            this.checkSession();
        }
        //registerSW();
        //this.openOfflineDB();
    },
    methods: {
        checkSession() {
            this.$store.dispatch('validateUserSession')
                .then(resp => {
                    //do nothing
                });
        },
       /* openOfflineDB() {
            this.$store.dispatch('openDatabase');
        }*/
    }
});//.$mount('#app');

/*async function registerSW() {
    if ('serviceWorker' in navigator) {
        try {
            await navigator.serviceWorker.register('./sw.js');
        } catch (e) {
            //alert(e)
            alert('ServiceWorker registration failed. Sorry about that.');
        }
    } else {
        document.querySelector('.alert').removeAttribute('hidden');
    }
}*/

