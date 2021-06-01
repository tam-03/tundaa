# frozen_string_literal: true

FactoryBot.define do
  factory :sample do
    sequence(:title) { |n| "テスト#{n}" }
    sequence(:body) { |n| "テスト#{n}の内容" }
    template_id  { 1 }
  end
end
