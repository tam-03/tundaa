<template>
  <v-container>
    <v-card
      class="mx-auto my-12 pa-5"
      max-width="500"
    >
      <div class="text-h5 text-center mb-5">
        ログイン
      </div>
      <form id="login">
        <div class="mr-2 ml-2">
          <v-btn
            class="mb-4"
            :href="githubLoginUrl"
            block
            large
            color="grey darken-3 white--text"
          >
            <v-icon
              left
              color="white"
            >
              mdi-github
            </v-icon>
            GitHubでログイン
          </v-btn>
          <v-btn
            class="mb-4"
            :href="googleLoginUrl"
            block
            large
            color="red darken-1 white--text"
          >
            <v-icon
              left
              color="white"
            >
              mdi-google
            </v-icon>
            Googleでログイン
          </v-btn>
        </div>
        <v-divider class="mb-3 mt-5" />
        <div class="mb-5">
          <v-text-field
            v-model="email"
            label="メールアドレス"
          />
          <v-text-field
            v-model="password"
            label="パスワード"
            :type="show ? 'text' : 'password'"
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show = !show"
          />
        </div>
        <v-card-actions>
          <v-btn
            class="mr-4"
            large
            block
            color="success"
            @click="login"
          >
            ログイン
          </v-btn>
        </v-card-actions>
      </form>
      <v-divider class="mb-3 mt-5" />
      <v-btn
        small
        to="/sign_up"
        text
        color="orange lighten-1 accent-4"
      >
        アカウントを登録する
      </v-btn>
    </v-card>
  </v-container>
</template>

<script>

  export default {
  data () {
    return {
      email: '',
      password:'',
      github: {
        url: '/api/auth/github',
        redirectUrl: `${window.location.protocol}//${window.location.host}/oauth/github/callback`
      },
      google: {
        url: '/api/auth/google_oauth2',
        redirectUrl: `${window.location.protocol}//${window.location.host}/oauth/google/callback`
      },
      show: false,
    }
  },
  computed: {
    githubLoginUrl () {
      return `${this.github.url}?auth_origin_url=${this.github.redirectUrl}`
    },
    googleLoginUrl () {
      return `${this.google.url}?auth_origin_url=${this.google.redirectUrl}`
    }
  },
  methods: {
    login() {
      this.$store.dispatch('login', {
        email: this.email,
        password: this.password
      })
      this.email = ''
      this.password = ''
    },
  }
  }
</script>

<style scoped>
*{ text-transform: none !important; }
</style>
