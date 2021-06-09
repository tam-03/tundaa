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
      href="/api/auth/github?auth_origin_url=http:/localhost:3000/oauth/github/callback"
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
      password:''
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
