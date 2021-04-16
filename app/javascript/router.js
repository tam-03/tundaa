import Vue from 'vue'
import VueRouter from 'vue-router'
import Welcome from './top/welcome'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [{ path: "/", component: Welcome}]
})