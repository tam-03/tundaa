<template>
  <v-container>
    <div class="text-h3 text-center ma-5">
      {{ (sample || '').title }}
    </div>
    <v-card
      id="markdown_preview"
    >
      <v-card-text>
        <markdown-it-vue
          class="md-body"
          :content="String((sample || '').body)"
        />
      </v-card-text>
    </v-card>
    <div class="text-center ma-10">
      <v-btn
        class="mr-4"
        :to="(sample || '').editUrl"
      >
        編集
      </v-btn>
      <v-btn
        class="mr-4"
        @click="deleteSample"
      >
        削除
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

export default {
  components: {
    MarkdownItVue
  },
   computed: {
     sample() {
       return this.$store.getters.sample
     }
   },
   created() {
     this.getSample()
   },
   methods: {
     getSample() {
       this.$store.dispatch('getSample', {
         template_id: this.$route.params.template_id,
         id: this.$route.params.id
       })
     },
     deleteSample() {
       this.$store.dispatch('deleteSample', {
         template_id: this.$route.params.template_id,
         id: this.$route.params.id
       })
     },
   }
}
</script>
