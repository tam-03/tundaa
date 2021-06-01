<template>
  <v-container
    fluid
  >
    <div class="text-h2 text-center ma-5">
      例文を編集
    </div>
    <div class="text-center mr-16 ml-16">
      <v-text-field
        id="title"
        v-model="sample.title"
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
          v-model="sample.body"
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
            :content="sample.body"
          />
        </v-card>
      </v-col>
    </v-row>
    <div class="text-center ma-10">
      <v-btn
        id="save_sample"
        color="orange lighten-1 accent-4"
        :disabled="!isAuthenticated || sample.title == ''"
        outlined
        large
        @click="editSample"
      >
        編集を保存する
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
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    sample() {
      return this.$store.getters.sample
    },
  },
  created() {
    this.getSample()
  },
  methods: {
    editSample() {
      this.$store.dispatch('editSample', {
        title: this.sample.title,
        body: this.sample.body,
        id: this.$route.params.id,
        template_id: this.$route.params.template_id,
      })
    },
    getSample() {
      this.$store.dispatch('getSample', {
        template_id: this.$route.params.template_id,
        id: this.$route.params.id,
      })
    },
  }
}
</script>
