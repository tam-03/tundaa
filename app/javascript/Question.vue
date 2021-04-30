<template>
  <div>
    <h1>個別</h1>
    <p>QuestionID: {{ $route.params.id }}</p>
    <p>{{ question.title }}</p>
    <markdown-it-vue
      class="md-body"
      :content="question.body"
    />
    <router-link :to="question.editUrl">
      <v-btn
        class="mr-4"
      >
        編集
      </v-btn>
    </router-link>
    <v-btn
      class="mr-4"
      @click="deleteQuestion"
    >
      削除
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
     }
   }
}
</script>
