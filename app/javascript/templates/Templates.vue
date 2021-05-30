<template>
  <v-container>
    <div class="text-h2 text-center ma-5">
      テンプレート
    </div>
    <div class="text-right">
      <v-btn
        class="ma-10"
        to="/templates/new"
      >
        新規作成
      </v-btn>
    </div>
    <v-row justify="center">
      <v-expansion-panels popout>
        <v-expansion-panel
          v-for="template in templates"
          :key="template.id"
        >
          <template v-if="!edit">
            <v-expansion-panel-header>
              {{ template.title }}
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <div class="text-body-1">
                {{ template.body }}
              </div>
              <div class="text-right mr-10">
                <router-link
                  :to="template.editUrl"
                >
                  <v-btn
                    class="mr-4"
                    @click="passTemplate(template)"
                  >
                    編集
                  </v-btn>
                </router-link>
              </div>
            </v-expansion-panel-content>
          </template>
          <template v-else>
            <edit-template />
          </template>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-row>
  </v-container>
</template>

<script>
import EditTemplate from './EditTemplate.vue'
export default {
  components: { EditTemplate },
  data() {
    return {
      edit: false,
    }
  },
  computed: {
    templates() {
      return this.$store.getters.templates
    },
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
    },
  }
}
</script>
