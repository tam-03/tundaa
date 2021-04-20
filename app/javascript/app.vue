<template>
  <v-app>
    <Header />
    <v-main>
      <h2>app.vue</h2>
      <Home />
      <Welcome />
      <router-view />
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import Home from './top/home'
import Welcome from './top/welcome'
import Header from './header'

export default {
  components: {
    'Home': Home,
    'Welcome': Welcome,
    'Header': Header
  }
}
</script>
