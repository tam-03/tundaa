import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from './login'
import SignUp from './signup'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: "/login", component: Login },
    { path: "/sign_up", component: SignUp }
  ]
})
