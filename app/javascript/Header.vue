<template>
  <v-app-bar
    color="orange lighten-1"
    dense
    dark
    app
    :class="{header: !isAuthenticated}"
  >
    <router-link
      to="/"
      class="text-decoration-none"
    >
      <v-toolbar-title class="white--text">
        Tundaa
      </v-toolbar-title>
    </router-link>

    <v-spacer />
    <template v-if="isAdmin">
      <router-link
        to="/templates"
        class="text-decoration-none"
      >
        <v-btn
          text
        >
          テンプレート一覧
        </v-btn>
      </router-link>
    </template>
    <router-link
      to="/questions"
      class="text-decoration-none"
    >
      <v-btn
        text
      >
        質問一覧
      </v-btn>
    </router-link>
    <v-btn
      text
      @click="logout"
    >
      ログアウト
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    isAdmin() {
      return this.$store.getters.admin
    },
  },
  methods: {
    logout() {
      this.$store.dispatch('logout')
    }
  }
}
</script>

<style scoped>
.header {
  display: none;
}
</style>
