<template>
  <v-container>
    <div class="text-h2 text-center ma-5">
      テンプレートを編集
    </div>
    <v-card>
      <v-card-title>
        <v-text-field
          id="title"
          v-model="template.title"
          label="タイトル"
          color="orange lighten-1 accent-4"
        />
      </v-card-title>
      <v-card-text>
        <v-textarea
          id="edit_template"
          v-model="template.body"
          name="body"
          rows="5"
          auto-grow
          outlined
          color="orange lighten-1 accent-4"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn
          class="mr-4"
          @click="editTemplate"
        >
          保存
        </v-btn>
        <v-btn
          class="mr-4"
          @click="deleteTemplate"
        >
          削除
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
export default {
  computed: {
    template() {
      return this.$store.getters.template
    },
  },
  methods: {
    editTemplate() {
      this.$store.dispatch('editTemplate', {
        id: this.template.id,
        title: this.template.title,
        body: this.template.body
      })
    },
    deleteTemplate() {
      this.$store.dispatch('deleteTemplate', {
        id: this.$route.params.id
      })
    },
  }
}
</script>
