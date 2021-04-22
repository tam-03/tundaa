import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: null
  },
  mutations: {
    updateToken(state, token) {
      state.token = token
    }
  },
  actions: {
    login({ commit }, authData) {
      axios.post('/api/auth/sign_in', {
        email: authData.email,
        password: authData.password,
      }).then(response => {
        commit('updateToken', response.headers['access-token'])
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
      })
    }
    }
})
