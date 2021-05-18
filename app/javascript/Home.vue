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
          :disabled="!isAuthenticated && template.id !== 1 ? disabled : !disabled"
          :class="`template-${template.id}`"
        >
          <v-icon
            x-large
            left
          >
            {{ template.icon }}
          </v-icon>
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
          "title": "何が分からないか分かっている",
          "body": 'テンプレートの内容 1',
          "icon": "mdi-emoticon-happy-outline",
        },
        {
          "id": 2,
          "title": "何が分からないか分からない",
          "body": "テンプレートの内容 2",
          "icon": "mdi-emoticon-confused-outline",
        },
        {
          "id": 3,
          "title": "もう何も分からない",
          "body": "テンプレートの内容 3",
          "icon": "mdi-emoticon-dead-outline",
        }
      ],
      disabled: true
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
