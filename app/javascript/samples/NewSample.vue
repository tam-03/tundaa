<template>
  <v-container
    fluid
  >
    <div class="text-h2 text-center ma-5">
      例文を作成
    </div>
    <div class="text-center mr-16 ml-16">
      <v-text-field
        v-model="title"
        label="タイトル"
        color="orange lighten-1 accent-4"
      />
    </div>
    <v-row
      no-gutters
      justify="center"
    >
      <v-col id="input_area">
        <v-textarea
          id="input_markdown"
          v-model="body"
          name="body"
          rows="11"
          auto-grow
          outlined
          color="orange lighten-1 accent-4"
        />
      </v-col>
      <v-col id="preview_and_sample_area">
        <v-card
          id="markdown_preview"
          class="pa-2"
          outlined
          min-height="275"
        >
          <markdown-it-vue
            class="md-body"
            :content="body"
          />
        </v-card>
      </v-col>
    </v-row>
    <div class="text-center ma-10">
      <v-btn
        id="save_question"
        color="orange lighten-1 accent-4"
        :disabled="!isAuthenticated || title == ''"
        outlined
        large
        @click="saveSample"
      >
        保存する
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

export default {
  components: {
    MarkdownItVue,
  },
  data() {
    return {
      title: '',
      body: '',
    }
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
  },
  methods: {
    saveSample() {
      this.$store.dispatch('saveSample', {
        title: this.title,
        body: this.body,
        template_id: this.$route.params.template_id,
      })
      this.title = ''
      this.body = ''
    },
  }
}
</script>
