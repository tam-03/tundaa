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
import axios from 'axios'

  export default {
  data () {
    return {
      email: '',
      passwaord:''
    }
  },
  methods: {
    login() {
      axios.post('/api/auth/sign_in', {
        email: this.email,
        password: this.password,
      }).then(response => {
        console.log(response)
      })
    }
  }
  }
</script>
