<template>
  <v-app-bar
    color="orange lighten-1"
    dense
    dark
    app
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
    <template v-if="!isAuthenticated">
      <router-link
        to="/"
        class="text-decoration-none"
      >
        <v-btn
          text
        >
          今すぐ始める
        </v-btn>
      </router-link>
      <router-link
        to="/login"
        class="text-decoration-none"
      >
        <v-btn text>
          ログイン
        </v-btn>
      </router-link>
      <router-link
        to="/sign_up"
        class="text-decoration-none"
      >
        <v-btn text>
          アカウント登録
        </v-btn>
      </router-link>
    </template>
    <template v-else>
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
    </template>
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
