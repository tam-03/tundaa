<template>
  <v-container>
    <h1 class="text-center logo">
      Tundaa
    </h1>
    <p class="mb-10 lead-text">
      質問の作成に困ったら<br>テンプレートを使ってみよう！
    </p>
    <div class="number mt-0 mb-10 mr-auto ml-auto">
      1
    </div>
    <v-row class="mb-16">
      <v-col
        class="d-flex justify-center align-end"
        style="flex-direction: column;"
      >
        <div class="mb-5">
          <div class="subtitle">
            テンプレートから質問を作成
          </div>
          <p class="app-description">
            分からないレベルに合わせてテンプレートを選択し<br>「作成」をクリック。 質問を作成してみよう！
          </p>
        </div>
      </v-col>
      <v-col>
        <v-seet
          class="d-flex justify-start"
          color="orange lighten-1 accent-4"
        >
          <img
            src="~create_template.png"
            height="200px"
          >
        </v-seet>
      </v-col>
    </v-row>
    <div class="number mt-0 mb-10 mr-auto ml-auto">
      2
    </div>
    <v-row class="mb-16">
      <v-col
        class="d-flex justify-center align-end"
        style="flex-direction: column;"
      >
        <div class="mb-5">
          <div class="subtitle">
            内容をワンクリックでコピー
          </div>
          <p class="app-description">
            プレビューの枠をクリックするとMarkdownのコピーができる<br>各種ツールに貼り付けして使おう！
          </p>
        </div>
      </v-col>
      <v-col>
        <v-seet
          class="d-flex justify-start"
          color="orange lighten-1 accent-4"
        >
          <img
            src="~copy_markdown.png"
            height="200px"
          >
        </v-seet>
      </v-col>
    </v-row>
    <div class="number mt-0 mb-10 mr-auto ml-auto">
      3
    </div>
    <v-row class="mb-16">
      <v-col
        class="d-flex justify-center align-end"
        style="flex-direction: column;"
      >
        <div class="mb-5">
          <div class="subtitle">
            例文を見ながら作成
          </div>
          <p class="app-description">
            どんなことを書いたら良いか分からない時には<br>例文タブからテンプレートを使った例文が見れる！
          </p>
        </div>
      </v-col>
      <v-col>
        <v-seet
          class="d-flex justify-start"
          color="orange lighten-1 accent-4"
        >
          <img
            src="~leading_sample.png"
            height="200px"
          >
        </v-seet>
      </v-col>
    </v-row>
    <div class="d-flex justify-center ma-10">
      <v-btn
        to="/home"
        color="orange lighten-1 accent-4"
        class="ma-2 white--text"
        x-large
      >
        Tundaaを使ってみる
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
  text-align: center;
  font-size: 35px;
}
.logo {
  font-family: 'Fugaz One', cursive;
  font-size: 100px;
  color: #FFA726;
}
.number {
  font-family: 'Fugaz One', cursive;
  font-size: 20px;
  color: white;
  width: 50px;
  height: 50px;
  background-color: #FFA726;
  display: flex;
  justify-content: center;
  align-items: center;
}
.subtitle {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 10px;
  text-align: end;
}
.app-description {
  text-align: left;
}
*{ text-transform: none !important; }
</style>
