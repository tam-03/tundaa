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
        color="orange lighten-1 accent-4"
        :rules="[rules.required]"
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
          v-model="body"
          name="body"
          rows="11"
          auto-grow
          outlined
          color="orange lighten-1 accent-4"
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
        <template v-if="preview">
          <v-card
            id="markdown_preview"
            class="pa-2"
            outlined
            min-height="275"
            @click="doCopy"
          >
            <markdown-it-vue
              class="md-body"
              :content="body"
            />
          </v-card>
        </template>
        <template v-else>
          <v-card
            class="pa-2"
            outlined
            min-height="275"
          >
            <SampleQuestion />
          </v-card>
        </template>
      </v-col>
    </v-row>
    <div class="text-center ma-10">
      <v-btn
        id="save_question"
        color="orange lighten-1 accent-4"
        :disabled="!isAuthenticated || title == ''"
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
import Vue from 'vue'
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'
import SampleQuestion from './SampleQuestion.vue'
import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)

export default {
  components: {
    MarkdownItVue,
    SampleQuestion,
  },
  data() {
    return {
      title: '',
      body: this.$store.getters.template.body,
      preview: true,
      rules: {
        required: value => !!value || 'タイトルを入力して下さい',
      },
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
        body: this.body
      })
      this.title = ''
      this.body = ''
    },
    doCopy() {
      this.$copyText(this.body).then(() => {
        this.$store.dispatch('setAlert', {
          type: "info",
          message: "Markdownをコピーしました"
        })
      })
    }
  }
}
</script>
