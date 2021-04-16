import Vue from 'vue'
import vuetify from '../packs/vuetify'
import App from './app.vue'
import router from '../router.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-app'
  const app = document.querySelector(selector)
  if (app) {
    const currentUserId = app.getAttribute('data-current-user-id')
    new Vue({
      vuetify,
      router,
      render: h => h(App, {
        props: { currentUserId }
      })
    }).$mount(selector)
  }
})
