import Vue from 'vue'
import vuetify from './packs/vuetify.js'
import App from './app.vue'
import router from './router.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#app'
  const app = document.querySelector(selector)
  if (app) {
    new Vue({
      vuetify,
      router,
      render: h => h(App, {
      })
    }).$mount(selector)
  }
})
