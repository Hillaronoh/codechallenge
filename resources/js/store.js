import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from "./routes";

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        status: '',
        token: localStorage.getItem('token') || '',
        user: JSON.parse(localStorage.getItem('user')) || {},
    },
    mutations: {
        auth_request(state) {
            state.status = 'loading'
        },
        auth_success(state, payload) {
            state.status = 'success';
            state.token = payload.token;
            state.user = JSON.parse(payload.user);
        },
        auth_error(state) {
            state.status = 'error'
        },
        logout(state) {
            state.status = '';
            state.token = '';
        }
    },
    actions: {
        login({commit, dispatch}, user) {
            return new Promise((resolve, reject) => {
                commit('auth_request');
                axios({url: 'authenticateUser', data: user, method: 'POST'})
                    .then(resp => {
                        var data = resp.data,
                            success = data.success,
                            message = data.message;
                        if ((success) || success == true) {
                            const token = data.token;
                            const user = JSON.stringify(data.user);
                            localStorage.setItem('token', token);
                            localStorage.setItem('user', user);
                            axios.defaults.headers.common['Authorization'] = 'Bearer ' + token;
                            commit('auth_success', {
                                token: token,
                                user: user
                            });
                            //dispatch('validateUserSession');
                            resolve(resp)
                        } else {
                            alert(message)
                        }
                    })
                    .catch(err => {
                        commit('auth_error');
                        localStorage.clear();
                        reject(err)
                    })
            })
        },

        logout({commit, dispatch}) {
            return new Promise((resolve, reject) => {
                commit('auth_request');
                axios.get("logoutUser")
                    .then((resp) => {
                        commit('logout');
                        //localStorage.removeItem('token');
                        localStorage.clear();
                        delete axios.defaults.headers.common['Authorization'];
                        //dispatch('validateUserSession');
                        resolve(resp)
                    })
                    .catch(err => {
                        commit('auth_error', err);
                        localStorage.clear();
                        reject(err)
                    })
            })
        }
    },

    getters: {
        isLoggedIn: state => !!state.token,
        authStatus: state => state.status
    }

});
