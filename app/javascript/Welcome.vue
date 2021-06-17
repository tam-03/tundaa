<template>
  <v-container
    fluid
  >
    <div class="text-h3 text-center mb-15">
      <p class="mb-10 lead-text">
        質問の作成に困ったら
      </p>
      <p class="lead-text">
        テンプレートを使ってみよう！
      </p>
    </div>
    <v-row>
      <v-col>
        <div class="text-subtitle-1 mb-5 text-center grey--text text--darken-2">
          テンプレートから質問を作成
        </div>
        <v-card>
          <img
            src="~create_template.png"
            height="200px"
          >
        </v-card>
      </v-col>
      <v-col>
        <div class="text-subtitle-1 mb-5 text-center grey--text text--darken-2">
          内容を1クリックでコピーして貼り付け
        </div>
        <v-card>
          <img
            src="~copy_markdown.png"
            height="200px"
          >
        </v-card>
      </v-col>
      <v-col>
        <div class="text-subtitle-1 mb-5 text-center grey--text text--darken-2">
          例文を見ながら作成 <span class="grey--text">(ログインユーザー限定)</span>
        </div>
        <v-card>
          <img
            src="~leading_sample.png"
            height="200px"
          >
        </v-card>
      </v-col>
    </v-row>
    <div class="d-flex justify-center ma-10">
      <v-btn
        to="/home"
        text
        color="orange lighten-1 accent-4"
        x-large
      >
        tundaaを使ってみる
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import 'create_template.png'
import 'copy_markdown.png'
import 'leading_sample.png'

export default {
  beforeRouteEnter(to, from, next) {
    const token = localStorage.getItem('token')
    if (token) {
      next("/home")
    } else {
      next()
    }
  }
}
</script>

<style scoped>
.lead-text {
  letter-spacing: 5px;
  font-weight: 100;
}
*{ text-transform: none !important; }
</style>
