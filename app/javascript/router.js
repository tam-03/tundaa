import Vue from 'vue'
import VueRouter from 'vue-router'
import store from './store'
const Welcome = () => import(/* webpackChunkName: "Welcome" */ './Welcome')
const Home = () => import(/* webpackChunkName: "Home" */ './Home')
const Login = () => import(/* webpackChunkName: "Login" */ './login')
const SignUp = () => import(/* webpackChunkName: "SignUp" */ './signup')
const NewQuestion = () => import(/* webpackChunkName: "NewQuestion" */ './NewQuestion')
const Questions = () => import(/* webpackChunkName: "Questions" */ './Questions')
const Question = () => import(/* webpackChunkName: "Question" */ './Question')
const EditQuestion = () => import(/* webpackChunkName: "EditQuestion" */ './EditQuestion')
const Templates = () => import(/* webpackChunkName: "Templates" */ './templates/Templates')
const NewTemplate = () => import(/* webpackChunkName: "NewTemplate" */ './templates/NewTemplate')
const EditTemplate = () => import(/* webpackChunkName: "EditQuestion" */ './templates/EditTemplate')
const Samples = () => import(/* webpackChunkName: "Samples" */ './samples/Samples')
const NewSample = () => import(/* webpackChunkName: "NewSample" */ './samples/NewSample')
const Sample = () => import(/* webpackChunkName: "Sample" */ './samples/Sample')
const EditSample = () => import(/* webpackChunkName: "EditSample" */ './samples/EditSample')
const GitHubCallback = () => import(/* webpackChunkName: "GitHubCallback" */ './oauth/GitHubCallback')
const GoogleCallback = () => import(/* webpackChunkName: "GoogleCallback" */ './oauth/GoogleCallback')

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
    {
      path: "/oauth/google/callback",
      component: GoogleCallback,
    },
  ]
})
