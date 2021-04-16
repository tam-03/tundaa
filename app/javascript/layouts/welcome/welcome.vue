<template>
  <v-app>
    <app-header-bar />
    <v-main>
      <h2>welcome</h2>
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import AppHeaderBar from './welcomeHeader.vue'

export default {
  components: {
    'app-header-bar': AppHeaderBar
  }
}
</script>
