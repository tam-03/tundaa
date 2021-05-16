<template>
  <div>
    <h2>登録</h2>
    <form id="register">
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

  export default {
  data () {
    return {
      email: '',
      password:'',
      password_confirmation: ''
    }
  },
  methods: {
    register() {
      this.$store.dispatch('register', {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation
      })
      this.email = ''
      this.password = ''
      this.password_confirmation = ''
    }
  }
  }
</script>
