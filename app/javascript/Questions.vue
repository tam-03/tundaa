<template>
  <div>
    <h1>一覧</h1>
    <div
      v-for="question in questions"
      :key="question.id"
    >
      <div>{{ question.title }}</div>
    </div>
  </div>
</template>

<script>
export default {
   computed: {
     questions() {
       return this.$store.getters.questions
     }
   },
   created() {
     this.getQuestions()
   },
   methods: {
     getQuestions() {
       this.$store.dispatch('getQuestions')
     }
   }
}
</script>
