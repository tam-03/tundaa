<template>
  <div>
    <h2>ログイン</h2>
    <form>
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
    }
  }
  }
</script>
