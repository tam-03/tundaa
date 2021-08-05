<template>
  <v-app>
    <Header />
    <v-main>
      <Alert />
      <router-view />
    </v-main>
    <v-footer padless>
      <v-col
        class="text-center"
        cols="12"
      >
        <v-btn
          small
          to="/rules"
          text
          color="orange lighten-1 accent-4"
        >
          利用規約
        </v-btn>
        <v-btn
          small
          to="/privacy_policy"
          text
          color="orange lighten-1 accent-4"
        >
          プライバシーポリシー
        </v-btn>
      </v-col>
      <v-col
        class="text-center"
        cols="12"
      >
        {{ new Date().getFullYear() }} — <strong>Tundaa</strong>
      </v-col>
    </v-footer>
  </v-app>
</template>

<script>
import Header from './Header'
import Alert from './Alert'

export default {
  components: {
    Header,
    Alert,
  },
}
</script>
