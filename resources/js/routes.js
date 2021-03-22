import Vue from 'vue'
import VueRouter from 'vue-router';
import store from "./store";

import DashView from './components/Dash.vue'
import LoginView from './components/Login.vue'
import NotFoundView from './components/page404.vue'

import suppliers from './components/views/Suppliers';
import products from './components/views/Products';
import orders from './components/views/Orders';
import supplierproducts from './components/views/SupplierProducts';

Vue.use(VueRouter);
const routes = [
    {
        path: '/login',
        component: LoginView,
        meta: {
            description: 'Login View'
        }
    },
    {
        path: '/',
        component: DashView,
        children: [
            {
                path: '/suppliers',
                component: suppliers,
                alias: '/',
                meta: {
                    requiresAuth: true,
                    description: 'Suppliers'
                }
            },
            {
                path: '/suppliers',
                component: suppliers,
                meta: {
                    requiresAuth: true,
                    description: 'Suppliers'
                }
            },
            {
                path: '/products',
                component: products,
                meta: {
                    requiresAuth: true,
                    description: 'Products'
                }
            },
            {
                path: '/orders',
                component: orders,
                meta: {
                    requiresAuth: true,
                    description: 'Orders'
                }
            },
            {
                path: '/supplierproducts',
                component: supplierproducts,
                meta: {
                    requiresAuth: true,
                    description: 'Supplier Products'
                }
            }
        ]
    },
    {
        path: '*',
        component: NotFoundView,
        meta: {
            plainLayout: true
        }
    },
];
let router = new VueRouter({
    mode: 'hash',
    //linkExactActiveClass: 'current-page',
    //linkActiveClass: 'current-page',
    routes
});
router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (store.getters.isLoggedIn) {
            next();
            return
        }
        next('/login')
    } else {
        next()
    }
});
export default router
