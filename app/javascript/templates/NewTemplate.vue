<template>
  <v-container>
    <div class="text-h2 text-center ma-5">
      テンプレートを新規作成
    </div>
    <v-card>
      <v-card-title>
        <v-text-field
          id="title"
          v-model="title"
          label="タイトル"
          color="orange lighten-1 accent-4"
        />
      </v-card-title>
      <v-card-text>
        <v-textarea
          id="edit_template"
          v-model="body"
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
          @click="saveTemplate"
        >
          保存
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      title: '',
      body: '',
    }
  },
  methods: {
    saveTemplate() {
      this.$store.dispatch('saveTemplate', {
        title: this.title,
        body: this.body,
      })
    },
  },
}
</script>
