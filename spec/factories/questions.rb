# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "テスト#{n}" }
    sequence(:body) { |n| "テスト#{n}の内容" }
    user_id { 1 }
  end
end
