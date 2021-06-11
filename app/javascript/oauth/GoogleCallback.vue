<template>
  <v-container fluid>
    <div class="text-h2 text-center ma-5">
      Googleでログインしています...
    </div>
  </v-container>
</template>

<script>
export default {
   created() {
     this.googleLogin()
   },
   methods: {
     googleLogin () {
       this.$store.dispatch('googleLogin', {
         token: this.$route.query.auth_token,
         uid: this.$route.query.uid,
         client: this.$route.query.client_id,
       })
     }
   }
}
</script>
