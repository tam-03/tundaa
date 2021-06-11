<template>
  <v-container fluid>
    <div class="text-h2 text-center ma-5">
      GitHubでログインしています...
    </div>
  </v-container>
</template>

<script>
export default {
   created() {
     this.githubLogin()
   },
   methods: {
     githubLogin () {
       this.$store.dispatch('githubLogin', {
         token: this.$route.query.auth_token,
         uid: this.$route.query.uid,
         client: this.$route.query.client_id,
       })
     }
   }
}
</script>
