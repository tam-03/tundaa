import Vue from 'vue'
import vuetify from '../../packs/vuetify.js'
import Home from './home.vue'
import router from '../../router.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-home'
  const home = document.querySelector(selector)
  if (home) {
    const currentUserId = home.getAttribute('data-current-user-id')
    new Vue({
      vuetify,
      router,
      render: h => h(Home, {
        props: { currentUserId }
      })
    }).$mount(selector)
  }
})
