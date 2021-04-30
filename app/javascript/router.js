import Vue from 'vue'
import VueRouter from 'vue-router'
import store from './store'
import Welcome from './Welcome'
import Home from './Home'
import Login from './login'
import SignUp from './signup'
import NewQuestion from './NewQuestion'
import Questions from './Questions'
import Question from './Question'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: "/",
      component: Welcome,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next('/home')
        } else {
          next()
        }
      }
    },
    {
      path: "/home",
      component: Home
    },
    {
      path: "/login",
      component: Login,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next('/home')
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
    },
    {
      path: "/questions/new",
      component: NewQuestion
    },
    {
      path: "/questions",
      component: Questions,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next()
        } else {
          next('/login')
        }
      }
    },
    {
      path: "/questions/:id",
      component: Question,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next()
        } else {
          next('/login')
        }
      }
    }
  ]
})
