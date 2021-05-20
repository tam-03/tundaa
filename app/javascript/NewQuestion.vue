<template>
  <v-container
    fluid
  >
    <div class="text-h2 text-center ma-5">
      質問を作成
    </div>
    <div class="text-center mr-16 ml-16">
      <v-text-field
        v-model="title"
        label="タイトル"
        placeholder="タイトルを入力して下さい"
      />
    </div>
    <v-row
      no-gutters
      justify="center"
    >
      <v-col id="input_area">
        <label
          for="body"
          style="display: block; padding: 10px;"
        >
          内容
        </label>
        <v-textarea
          v-model="content"
          name="body"
          rows="10"
          outlined
        />
      </v-col>
      <v-col id="preview_and_sample_area">
        <label
          for="preview"
        >
          <v-btn
            color="orange lighten-1 accent-4"
            text
            large
            @click="preview = true"
          >
            プレビュー
          </v-btn>
          <v-btn
            color="orange lighten-1 accent-4"
            text
            :disabled="!isAuthenticated"
            large
            @click="preview = false"
          >
            例文
          </v-btn>
        </label>
        <v-card
          class="pa-2"
          outlined
          min-height="292"
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
    <div class="text-center ma-10">
      <v-btn
        color="orange lighten-1 accent-4"
        :disabled="!isAuthenticated"
        outlined
        large
        @click="saveQuestion"
      >
        保存する
      </v-btn>
      <div
        v-if="!isAuthenticated"
        class="text-caption"
      >
        会員登録をすると保存が出来ます
      </div>
    </div>
  </v-container>
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
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
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
