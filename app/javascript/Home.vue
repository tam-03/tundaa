<template>
  <v-container>
    <div class="text-h2 text-center ma-10">
      質問を作成する
    </div>
    <v-row
      v-for="n in 1"
      :key="n"
      :class="n === 1 ? 'mb-6' : ''"
      no-gutters
    >
      <v-col
        v-for="template in templates"
        :key="template.id"
        class="ma-5"
      >
        <v-card
          class="pa-2"
          elevation="2"
          shaped
          :disabled="!isAuthenticated && !template.free ? disabled : !disabled"
          :class="`template-${template.id}`"
        >
          <v-icon
            x-large
            left
          >
            {{ icons[template.id - 1] }}
          </v-icon>
          <v-card-title>{{ template.title }}</v-card-title>
          <v-card-text>
            <pre>{{ template.body }}</pre>
          </v-card-text>
          <v-card-actions>
            <router-link
              :to="`/questions/new/?template=${template.id}`"
              class="text-decoration-none"
            >
              <template v-if="!isAuthenticated && !template.free">
                <v-btn
                  color="orange lighten-1 accent-4"
                  text
                  large
                >
                  会員登録をするとご覧頂けます
                </v-btn>
              </template>
              <template v-else>
                <v-btn
                  color="orange lighten-1 accent-4"
                  text
                  large
                  @click="passTemplate(template)"
                >
                  作成
                </v-btn>
              </template>
            </router-link>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>

export default {
  name: 'Home',
  data() {
    return {
      disabled: true,
      icons: [
        "mdi-emoticon-happy-outline",
        "mdi-emoticon-confused-outline",
        "mdi-emoticon-dead-outline",
      ],
    }
  },
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
    },
    passTemplate(template) {
      this.$store.dispatch('passTemplate', {
        template: template
      })
    }
  }
}
</script>
