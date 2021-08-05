<template>
  <v-card
    height="40"
    max-width
    outlined
    style="border: none;"
    :class="{alert: !isAuthenticated}"
  >
    <v-alert
      v-if="isAlert"
      :type="alertType"
      dismissible
      dense
    >
      {{ alertMessage }}
    </v-alert>
  </v-card>
</template>

<script>
export default {
  computed: {
    isAlert () {
      return this.$store.getters.alertType !== null
    },
    alertType () {
      return this.$store.getters.alertType
    },
    alertMessage () {
      return this.$store.getters.alertMessage
    },
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
  }
}
</script>

<style scoped>
.alert {
  display: none;
}
</style>
