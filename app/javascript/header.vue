<template>
  <v-app-bar
    color="deep-purple accent-4"
    dense
    dark
  >
    <v-toolbar-title>Tundaa</v-toolbar-title>

    <v-spacer />
    <a href="#">
      <v-btn>
        今すぐ始める
      </v-btn>
    </a>
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
  </v-app-bar>
</template>

<script>

export default {
}
</script>
