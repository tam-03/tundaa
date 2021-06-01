<template>
  <v-container>
    <div class="text-h2 text-center ma-5">
      例文一覧
    </div>
    <div
      id="new_template"
      class="text-right"
    >
      <v-btn
        class="ma-10"
        :to="`/templates/${$route.params.template_id}/samples/new`"
      >
        新規作成
      </v-btn>
    </div>
    <v-row
      v-for="sample in samples"
      :key="sample.id"
      no-gutters
      :class="`sample-${sample.id}`"
    >
      <v-col>
        <v-hover v-slot="{ hover }">
          <v-card
            outlined
            tile
            :elevation="hover ? 12 : 2"
            :class="{ 'on-hover': hover }"
            class="d-flex justify-space-between"
          >
            <router-link
              :to="sample.url"
              class="text-decoration-none orange--text text--lighten-1"
            >
              <v-card-title
                :class="{ 'text--secondary': !hover, 'text-decoration-underline': hover }"
              >
                {{ sample.title }}
              </v-card-title>
            </router-link>
            <v-card-actions class="text-right">
              <v-btn
                id="edit_sample_btn"
                class="mx-2"
                fab
                dark
                small
                color="orange lighten-1 accent-4"
                :to="sample.editUrl"
              >
                <v-icon dark>
                  mdi-pencil
                </v-icon>
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-hover>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  computed: {
    samples() {
      return this.$store.getters.samples
    },
  },
  created() {
    this.getSamples()
  },
  methods: {
    getSamples() {
      this.$store.dispatch('getSamples', {
        template_id: this.$route.params.template_id,
      })
    },
  }
}
</script>
