# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |n|
  User.create!(
    email: "test#{n + 1}@example.com",
    password: "testtest"
  )
end

User.create!(
  email: "tundaa@example.com",
  password: "testtest",
  admin: true
)

Template.create!(
  title: "何が分からないか分かっている",
  body: "## 困っている事・問題の概要\n## 期待する結果とその理由\n## 作業手順・再現手順\n## 環境\n## 試した事・調べた事\n## エラーメッセージ\n## ソースコード",
  free: true
)

Template.create!(
  title: "何が分からないか分からない",
  body: "## 実現したい事\n## 作業手順・再現手順\n## 環境\n## 試した事・調べた事\n## エラーメッセージ\n## ソースコード"
)

Template.create!(
  title: "もう何も分からない",
  body: "## 目的\n## 目的の理由\n## ゴール\n## 試した事・調べた事\n## 環境"
)

3.times do |n|
  Question.create!(
    title: "タイトル#{n + 1}",
    body: "内容 #{n + 1}",
    user_id: 1,
    template_id: Template.find(n + 1).id
  )
end

Sample.create!(
  title: "【問題を簡潔にまとめたタイトル】",
  body: "- 「〇〇で△△というエラー」\n- 「〇〇が実行出来ない」\n- 「〇〇と✖︎✖︎の違い」\n\n## 困っている事・問題の概要\n【実現したい事】をやりたくて、【予想した結果】になると思い、【やった事】を試したのですが、【実際の結果】となり、上手くいきません。\n\n## 期待する結果とその理由\n〇〇となり処理が上手くいく。\n【公式のREADMEや参考資料】の手順に従い正しい手順で実装していると考えているため\n\n参考\n- 【参考にした資料等のリンク】\n\n## 作業手順・再現手順\n1.\n1.\n1.\n【スクリーンショットや動画】\n\n```bash\n$ history\n【historyコマンドの出力結果等】\n```\n\n## 環境\n- 端末: (MacBook Pro 2018/13インチ)\n- OS: (macOS Big Sur(11.0))\n- シェル: (bash)\n- 言語: (Ruby: 3.0.0)\n- フレームワーク: (Rails: 6.1.3)\n- DB: (MySQL)\n\n## 試した事・調べた事\n- 【サーバー等の】再起動\n- タイプミスではないかの検証\n- ネットワーク環境の確認\n\n以下を参考に〇〇や△△を試しました。\n\n参考\n- 【参考にした資料等のリンク】\n\n## エラーメッセージ\n```bash\n【適切な文量のエラーメッセージ】\n```\n\n## ソースコード\n```\n【適切な文量のソースコード】\n```\n\nGitHubを使っている場合は\n【問題が起きているブランチのPullRequestやリンク等】",
  template_id: Template.find(1).id
)

Sample.create!(
  title: "【問題を簡潔にまとめたタイトル】",
  body: "- 「〇〇で△△というエラー」\n- 「〇〇が実行出来ない」\n- 「〇〇と✖︎✖︎の違い」\n\n## 実現したい事\n【実現したい事】がやりたくて、【参考にした資料等】を参考に【やった事】を試したのですが、【実際の結果】となり、上手くいきません。\nお手数ですが、このやり方でよいか確認してもらえませんか？\n\n## 作業手順・再現手順\n1.\n1.\n1.\n【スクリーンショットや動画】\n\n```bash\n$ history\n【historyコマンドの出力結果等】\n```\n\n## 環境\n- 端末: (MacBook Pro 2018/13インチ)\n- OS: (macOS Big Sur(11.0))\n- シェル: (bash)\n- 言語: (Ruby: 3.0.0)\n- フレームワーク: (Rails: 6.1.3)\n- DB: (MySQL)\n\n## 試した事・調べた事\n- 【サーバー等の】再起動\n- タイプミスではないかの検証\n- ネットワーク環境の確認\n\n以下を参考に〇〇や△△を試しました。\n\n参考\n- 【参考にした資料等のリンク】\n\n## エラーメッセージ\n```bash\n【適切な文量のエラーメッセージ】\n```\n\n## ソースコード\n```\n【適切な文量のソースコード】\n```\n\nGitHubを使っている場合は\n【問題が起きているブランチのPullRequestやリンク等】",
  template_id: Template.find(2).id
)

Sample.create!(
  title: "【問題を簡潔にまとめたタイトル】",
  body: "- 「〇〇で△△というエラー」\n- 「〇〇が実行出来ない」\n- 「〇〇と✖︎✖︎の違い」\n\n## 目的\n【目的】をやりたくて、【手段】がやりたいのですが、やり方が分かりません。\nお力添え頂けないでしょうか？\n\n## 目的の理由\n【目的】をやりたい理由は【目的の理由】です。\n\n## ゴール\n【目的が達成された後の状態】\n\n## 試した事・調べた事\n- 【サーバー等の】再起動\n- タイプミスではないかの検証\n- ネットワーク環境の確認\n\n以下を参考に〇〇や△△を試しました。\n\n参考\n- 【参考にした資料等のリンク】\n\n## 環境\n- 端末: (MacBook Pro 2018/13インチ)\n- OS: (macOS Big Sur(11.0))\n- シェル: (bash)\n- 言語: (Ruby: 3.0.0)\n- フレームワーク: (Rails: 6.1.3)\n- DB: (MySQL)",
  template_id: Template.find(3).id
)
