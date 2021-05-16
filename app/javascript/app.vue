<template>
  <v-app>
    <Header />
    <v-main>
      <Alert />
      <router-view />
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import Header from './Header'
import Alert from './Alert'

export default {
  components: {
    'Header': Header,
    'Alert': Alert
  }
}
</script>
