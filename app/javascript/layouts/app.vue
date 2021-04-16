<template>
  <v-app>
    <app-header-bar />
    <v-main>
      <h2>{{ currentUser.signed_in }}</h2>
      <template v-if="currentUser.signed_in">
        <home />
      </template>
      <template v-else>
        <welcome />
      </template>
    </v-main>
    <v-footer app>
    <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import AppHeaderBar from './app-header-bar'
import Welcome from '../top/welcome'
import Home from '../top/home'

export default {
  components: {
    'app-header-bar': AppHeaderBar,
    'welcome': Welcome,
    'home': Home
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
    this.getCurrentUser()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getCurrentUser() {
      fetch(`/api/users/${this.currentUserId}.json`, {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      },
      credentials: "same-origin",
      redirect: "manual"
    })
      .then(response => {
        return response.json();
      })
      .then(json => {
        for (var key in json) {
          this.$set(this.currentUser, key, json[key]);
        }
      })
      .catch(error => {
        console.warn("Failed to parsing", error);
      });
    }
  }
}
</script>
