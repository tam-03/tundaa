import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from 'router'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: null,
    uid: null,
    client: null
  },
  getters: {
    token: state => state.token
  },
  mutations: {
    updateToken(state, token) {
      state.token = token
    },
    updateUid(state, uid) {
      state.token = uid
    },
    updateclient(state, client) {
      state.token = client
    }
  },
  actions: {
    login({ commit }, authData) {
      axios.post('/api/auth/sign_in', {
        email: authData.email,
        password: authData.password,
      }).then(response => {
        commit('updateToken', response.headers['access-token'])
        commit('updateUid', response.headers['uid'])
        commit('updateclient', response.headers['client'])
        router.push('/')
      })
    },
    register({ commit }, authData) {
      axios.post('/api/auth/', {
        email: authData.email,
        password: authData.password,
        password_confirmation: authData.password_confirmation
      }).then(response => {
        console.log(response)
        commit('updateToken', response.headers['access-token'])
        commit('updateUid', response.headers['uid'])
        commit('updateclient', response.headers['client'])
        router.push('/')
      })
    }
    }
})
