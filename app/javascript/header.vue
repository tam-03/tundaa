<template>
  <v-app-bar
    color="deep-purple accent-4"
    dense
    dark
    app
  >
    <v-toolbar-title>Tundaa</v-toolbar-title>

    <v-spacer />
    <template v-if="isAuthenticated">
      <router-link to="/">
        <v-btn>
          今すぐ始める
        </v-btn>
      </router-link>
      <router-link to="/login">
        <v-btn>
          ログイン
        </v-btn>
      </router-link>
      <router-link to="/sign_up">
        <v-btn>
          アカウント登録
        </v-btn>
      </router-link>
    </template>
    <template v-else>
      <v-btn @click="logout">
        ログアウト
      </v-btn>
      <p>{{ uid }}</p>
    </template>
  </v-app-bar>
</template>

<script>
import axios from 'axios'

export default {
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    uid() {
      return this.$store.getters.uid
    },
    token() {
      return this.$store.getters.token
    },
    client() {
      return this.$store.getters.client
    },
  },
  methods: {
    logout() {
      axios.delete('api/auth/sign_out', {
        headers: {
          uid: this.uid,
          token: this.token,
          client: this.client
        }
      })
    }
  }
}
</script>
