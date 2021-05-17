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
          :class="`template-${template.id}`"
        >
          <v-card-title>{{ template.title }}</v-card-title>
          <v-card-text>
            {{ template.body }}
          </v-card-text>
          <v-card-actions>
            <router-link
              to="/questions/new"
              class="text-decoration-none"
            >
              <v-btn
                color="orange lighten-1 accent-4"
                text
                @click="passTemplate(template)"
              >
                作成
              </v-btn>
            </router-link>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  beforeRouteEnter(to, from, next) {
    next(vm => vm.getTemplates())
  },
  data() {
    return {
      templates: [
        {
          "id": 1,
          "title": "テンプレートタイトル1",
          "body": "テンプレートの内容 1"
        },
        {
          "id": 2,
          "title": "テンプレートタイトル2",
          "body": "テンプレートの内容 2"
        },
        {
          "id": 3,
          "title": "テンプレートタイトル3",
          "body": "テンプレートの内容 3"
        } ]
    }
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    // templates() {
    //    return this.$store.getters.templates
    // }
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
