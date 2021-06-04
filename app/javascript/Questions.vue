<template>
  <v-container>
    <div class="text-h2 text-center ma-5">
      一覧
    </div>
    <v-row
      v-for="question in questions"
      :key="question.id"
      no-gutters
      :class="`question-${question.id}`"
    >
      <v-col>
        <v-hover v-slot="{ hover }">
          <v-card
            outlined
            tile
            :elevation="hover ? 12 : 2"
            :class="{ 'on-hover': hover }"
            class="d-flex justify-space-between"
          >
            <router-link
              :to="question.url"
              class="text-decoration-none orange--text text--lighten-1"
            >
              <v-card-title
                :class="{ 'text--secondary': !hover, 'text-decoration-underline': hover }"
              >
                {{ question.title }}
              </v-card-title>
            </router-link>
            <v-card-actions class="text-right">
              <v-btn
                id="edit_question_btn"
                class="mx-2"
                fab
                dark
                small
                color="orange lighten-1 accent-4"
                :to="`${question.editUrl}/?template=${question.template_id}`"
              >
                <v-icon dark>
                  mdi-pencil
                </v-icon>
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-hover>
      </v-col>
    </v-row>
  </v-container>
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
