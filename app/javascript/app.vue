<template>
  <v-app>
    <Header />
    <v-main>
      <router-view />
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import Header from './header'

export default {
  components: {
    'Header': Header
  }
}
</script>
