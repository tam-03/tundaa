<template>
  <div>
    <h2>ログイン</h2>
    <form id="login">
      <v-text-field
        v-model="email"
        label="email"
      />
      <v-text-field
        v-model="password"
        label="password"
      />
      <v-btn
        class="mr-4"
        @click="login"
      >
        ログイン
      </v-btn>
      <v-btn
        class="mr-4"
        :href="githubLoginUrl"
      >
        GitHubでログイン
      </v-btn>
      <v-btn
        class="mr-4"
        :href="googleLoginUrl"
      >
        Googleでログイン
      </v-btn>
    </form>
  </div>
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
