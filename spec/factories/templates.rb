# frozen_string_literal: true

FactoryBot.define do
  factory :template do
    sequence(:title) { |n| "テスト#{n}" }
    sequence(:body) { |n| "テスト#{n}の内容" }
  end
end
