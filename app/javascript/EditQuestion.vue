<template>
  <div>
    <h1>質問を編集</h1>
    <v-container
      fluid
      class="grey lighten-5"
    >
      <input
        v-model="title"
        type="text"
      >
      <v-row
        no-gutters
      >
        <v-col>
          <v-card
            class="pa-2"
            outlined
            tile
          >
            <v-textarea
              v-model="content"
              name="input-7-4"
            />
          </v-card>
        </v-col>
        <v-col>
          <v-card
            class="pa-2"
            outlined
            tile
          >
            <markdown-it-vue
              class="md-body"
              :content="content"
            />
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-btn @click="editQuestion">
      編集を保存
    </v-btn>
  </div>
</template>

<script>
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

export default {
  components: {
    MarkdownItVue
  },
  data() {
    return {
      title: this.$store.getters.question.title,
      content: this.$store.getters.question.body
    }
  },
  methods: {
    editQuestion() {
      this.$store.dispatch('editQuestion', {
        title: this.title,
        body: this.content,
        id: this.$route.params.id
      })
      this.title = ''
      this.content = ''
    }
  }
}
</script>
