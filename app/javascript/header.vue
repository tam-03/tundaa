<template>
  <v-app-bar
    color="deep-purple accent-4"
    dense
    dark
    app
  >
    <v-toolbar-title>Tundaa</v-toolbar-title>

    <v-spacer />
    <template v-if="!isAuthenticated">
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
      <router-link to="/questions">
        <v-btn>
          質問一覧
        </v-btn>
      </router-link>
      <v-btn @click="logout">
        ログアウト
      </v-btn>
    </template>
  </v-app-bar>
</template>

<script>

export default {
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    }
  },
  methods: {
    logout() {
      this.$store.dispatch('logout')
    }
  }
}
</script>
