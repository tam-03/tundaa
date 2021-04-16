<template>
  <v-app>
    <app-header-bar />
    <v-main>
      <!-- <h2>{{ String(currentUser.username) }}</h2> -->
      <router-view />
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import AppHeaderBar from './app-header-bar'

export default {
  components: {
    'app-header-bar': AppHeaderBar
  },
  props: {
    currentUserId: {
      type: String,
      required: true
    }
  },
  data: () => {
    return {
      currentUser: {}
    }
  },
  created: function () {
    console.log(this.currentUserId)
  }
}
</script>
