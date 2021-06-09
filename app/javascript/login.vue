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
    </form>
    <v-btn
      class="mr-4"
      :href="githubLoginUrl"
    >
      GitHubでログイン
    </v-btn>
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
      }
    }
  },
  computed: {
    githubLoginUrl () {
      return `${this.github.url}?auth_origin_url=${this.github.redirectUrl}`
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
