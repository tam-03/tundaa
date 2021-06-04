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
  body: "## 困っている事\n## 期待する結果\n## 作業手順\n## エラーメッセージ\n## ソースコード\n## 試した事・調べた事\n## 環境",
  free: true
)

Template.create!(
  title: "何が分からないか分からない",
  body: "## 解決したい問題\n## 期待する結果\n## 問題が起きた箇所\n## 試した事・調べた事\n## 環境"
)

Template.create!(
  title: "もう何も分からない",
  body: "## 目的\n## ゴール\n## 悩み\n## 聞きたい事\n## 環境"
)

3.times do |n|
  Question.create!(
    title: "タイトル#{n + 1}",
    body: "内容 #{n + 1}",
    user_id: 1,
    template_id: Template.find(n + 1).id
  )
end

3.times do |n|
  Sample.create!(
    title: "サンプルタイトル#{n + 1}",
    body: "サンプルの内容 #{n + 1}",
    template_id: Template.find(1).id
  )
end

3.times do |n|
  Sample.create!(
    title: "サンプルタイトル#{n + 1}",
    body: "サンプルの内容 #{n + 1}",
    template_id: Template.find(2).id
  )
end

3.times do |n|
  Sample.create!(
    title: "サンプルタイトル#{n + 1}",
    body: "サンプルの内容 #{n + 1}",
    template_id: Template.find(3).id
  )
end
