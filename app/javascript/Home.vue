<template>
  <v-container>
    <h2>質問を作成する</h2>
    <v-row
      v-for="n in 1"
      :key="n"
      :class="n === 1 ? 'mb-6' : ''"
      no-gutters
    >
      <v-col
        v-for="template in templates"
        :key="template.id"
      >
        <v-card
          class="pa-2"
          elevation="2"
          outlined
          shaped
          tile
        >
          <v-card-title>{{ template.title }}</v-card-title>
          <v-card-text>
            {{ template.body }}
          </v-card-text>
          <v-card-actions>
            <v-btn
              color="orange lighten-1 accent-4"
              text
              to="/questions/new"
            >
              作成
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    templates() {
       return this.$store.getters.templates
    }
  },
  created() {
    this.getTemplates()
  },
  methods: {
    getTemplates() {
       this.$store.dispatch('getTemplates')
     }
  }
}
</script>
