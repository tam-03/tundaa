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
      <v-btn @click="preview = true">
        プレビュー
      </v-btn>
      <v-btn @click="preview = false">
        例文
      </v-btn>
      <v-row
        no-gutters
      >
        <v-col id="input_area">
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
        <v-col id="preview_and_sample_area">
          <v-card
            class="pa-2"
            outlined
            tile
          >
            <template v-if="preview">
              <markdown-it-vue
                class="md-body"
                :content="content"
              />
            </template>
            <template v-else>
              <SampleQuestion />
            </template>
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
import SampleQuestion from './SampleQuestion.vue'

export default {
  components: {
    MarkdownItVue,
    SampleQuestion,
  },
  data() {
    return {
      title: '',
      content: this.$store.getters.template.body,
      preview: true,
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
