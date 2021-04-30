<template>
  <div>
    <h1>質問を作成</h1>
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
    <v-btn @click="saveQuestion">
      保存する
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
      title: '',
      content: ''
    }
  },
  methods: {
    saveQuestion() {
      this.$store.dispatch('saveQuestion', {
        title: this.title,
        content: this.content
      })
      this.title = ''
      this.content = ''
    }
  }
}
</script>
