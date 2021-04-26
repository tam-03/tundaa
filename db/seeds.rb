# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |n|
  Template.create!(
    title: "テンプレートタイトル#{n + 1}",
    body: "テンプレートの内容 #{n + 1}"
  )
end

3.times do |n|
  Sample.create!(
    title: "サンプルタイトル#{n + 1}",
    body: "サンプルの内容 #{n + 1}"
  )
end
