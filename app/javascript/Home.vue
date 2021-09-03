<template>
  <v-container class="d-flex justify-start align-center flex-column">
    <div class="text-h3 text-center ma-10">
      あなたの状態に近いものはどれ？
    </div>
    <p class="text--secondary text-center mb-10">
      分からないレベルを表しています。<br>今のあなたの状態に一番近いものを選択して質問文を作成してみよう！
    </p>
    <template v-if="overlay">
      <v-overlay :value="overlay">
        <v-card
          class="mx-auto"
          elevation="2"
          outlined
        >
          <v-card-title>{{ modalTemplate.title }}</v-card-title>
          <v-card-text>
            <pre>{{ modalTemplate.body }}</pre>
          </v-card-text>
          <v-card-actions>
            <v-btn
              color="error"
              @click="overlay = !overlay"
            >
              閉じる
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-overlay>
    </template>
    <div>
      <v-row
        v-for="template in templates"
        :key="template.id"
        class="template-border"
      >
        <v-col>
          <v-card
            :class="`template-${template.id} text-center d-flex justify-space-between align-center pa-5`"
            :disabled="!isAuthenticated && !template.free"
          >
            <v-icon
              x-large
              center
              class="mr-5"
            >
              {{ icons[template.id - 1] }}
            </v-icon>
            <div class="text-h5">
              {{ template.title }}
            </div>
            <div class="d-flex flex-column">
              <router-link
                :to="`/questions/new/?template=${template.id}`"
                class="text-decoration-none"
              >
                <template v-if="!isAuthenticated && !template.free">
                  <v-btn
                    color="grey darken-1"
                    class="white--text pr-5 pl-5 mr-5 ml-5 mb-3"
                  >
                    要会員登録
                  </v-btn>
                </template>
                <template v-else>
                  <v-btn
                    color="orange lighten-1 accent-2"
                    class="white--text pr-5 pl-5 mr-5 ml-5 mb-3"
                    @click="passTemplate(template)"
                  >
                    選択
                  </v-btn>
                </template>
              </router-link>
              <div>
                <template v-if="!isAuthenticated && !template.free">
                  <v-btn
                    color="red darken-1"
                    text
                    small
                  >
                    会員登録が必要です
                  </v-btn>
                </template>
                <template v-else>
                  <v-btn
                    color="orange lighten-1 accent-4"
                    text
                    small
                    @click="openModal(template)"
                  >
                    内容を見る
                  </v-btn>
                </template>
              </div>
            </div>
          </v-card>
        </v-col>
      </v-row>
    </div>
    <template v-if="!isAuthenticated">
      <v-btn
        color="orange lighten-1 accent-4"
        x-large
        class="mt-10 mb-5 white--text"
        to="/sign_up"
      >
        会員登録
      </v-btn>
      <div class="text-body-1 text-center mb-5 text--secondary">
        会員登録をすると全てのテンプレートを使用でき<br>質問文の保存や編集もできるようになります。
      </div>
    </template>
  </v-container>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      disabled: true,
      icons: [
        "mdi-emoticon-happy-outline",
        "mdi-emoticon-confused-outline",
        "mdi-emoticon-dead-outline",
      ],
      overlay: false,
    }
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    },
    templates() {
      return this.$store.getters.templates
    },
    modalTemplate() {
      return this.$store.getters.template
    }
  },
  created() {
    this.getTemplates()
  },
  methods: {
    getTemplates() {
      this.$store.dispatch('getTemplates')
    },
    passTemplate(template) {
      this.$store.dispatch('passTemplate', {
        template: template
      })
    },
    openModal(template) {
      this.$store.dispatch('passTemplate', {
        template: template
      }).then(() => {
        this.overlay = true
      })
    }
  }
}
</script>
