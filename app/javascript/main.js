import Vue from 'vue'
import vuetify from './packs/vuetify.js'
import App from './app.vue'
import router from './router.js'
import store from './store.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#app'
  const app = document.querySelector(selector)
  if (app) {
    store.dispatch('validateToken')
    new Vue({
      vuetify,
      router,
      store,
      render: h => h(App, {
      })
    }).$mount(selector)
  }
})
