<template>
  <v-container>
    <div class="text-h3 text-center ma-5">
      {{ question.title }}
    </div>
    <v-card
      id="markdown_preview"
      @click="doCopy"
    >
      <v-card-text>
        <markdown-it-vue
          class="md-body"
          :content="question.body"
        />
      </v-card-text>
    </v-card>
    <div class="text-center ma-10">
      <v-btn
        class="mr-4"
        :to="question.editUrl"
      >
        編集
      </v-btn>
      <v-btn
        class="mr-4"
        @click="deleteQuestion"
      >
        削除
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import Vue from 'vue'
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'
import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)

export default {
  components: {
    MarkdownItVue
  },
   computed: {
     question() {
       return this.$store.getters.question
     }
   },
   created() {
     this.getQuestion()
   },
   methods: {
     getQuestion() {
       this.$store.dispatch('getQuestion', {
         questionId: this.$route.params.id
       })
     },
     deleteQuestion() {
       this.$store.dispatch('deleteQuestion', {
         id: this.$route.params.id
       })
     },
     doCopy() {
      this.$copyText(this.question.body).then(() => {
        this.$store.dispatch('setAlert', {
          type: "info",
          message: "Markdownをコピーしました"
        })
      })
    }
   }
}
</script>
