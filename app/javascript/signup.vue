<template>
  <div>
    <h2>登録</h2>
    <form>
      <v-text-field
        v-model="email"
        label="email"
      />
      <v-text-field
        v-model="password"
        label="password"
      />
      <v-text-field
        v-model="password_confirmation"
        label="password_confirmation"
      />
      <v-btn
        class="mr-4"
        @click="register"
      >
        登録
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
      passwaord:'',
      password_confirmation: ''
    }
  },
  methods: {
    register() {
      axios.post('/api/auth', {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation
      }).then(response => {
        console.log(response)
      })
    }
  }
  }
</script>
