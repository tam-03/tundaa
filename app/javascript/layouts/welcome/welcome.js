import Vue from 'vue'
import vuetify from '../../packs/vuetify.js'
import Welcome from './welcome.vue'
import router from '../../router.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-welcome'
  const welcome = document.querySelector(selector)
  if (welcome) {
    new Vue({
      vuetify,
      router,
      render: h => h(Welcome, {
      })
    }).$mount(selector)
  }
})
