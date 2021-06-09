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
import EditQuestion from './EditQuestion'
import Templates from './templates/Templates'
import NewTemplate from './templates/NewTemplate'
import EditTemplate from './templates/EditTemplate'
import Samples from './samples/Samples'
import NewSample from './samples/NewSample'
import Sample from './samples/Sample'
import EditSample from './samples/EditSample'
import GitHubCallback from './oauth/GitHubCallback'

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
    },
    {
      path: "/questions/:id/edit",
      component: EditQuestion,
      beforeEnter(to, from, next) {
        if (store.getters.token) {
          next()
        } else {
          next('/login')
        }
      }
    },
    {
      path: "/templates",
      component: Templates,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/new",
      component: NewTemplate,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/:id/edit",
      component: EditTemplate,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/:template_id/samples",
      component: Samples,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/:template_id/samples/new",
      component: NewSample,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/:template_id/samples/:id",
      component: Sample,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/templates/:template_id/samples/:id/edit",
      component: EditSample,
      beforeEnter(to, from, next) {
        if (store.getters.admin) {
          next()
        } else {
          next('/home')
        }
      }
    },
    {
      path: "/oauth/github/callback",
      component: GitHubCallback,
    },
  ]
})
