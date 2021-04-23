import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from './login'
import SignUp from './signup'
import store from './store'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: "/login",
      component: Login,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next('/')
        } else {
          next()
        }
      }
    },
    {
      path: "/sign_up",
      component: SignUp,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next('/')
        } else {
          next()
        }
      }
    }
  ]
})
