# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "新規作成", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-1" do
        click_button "作成"
      end
      expect(page).to have_content("テンプレートの内容 1")
    end
  end
end
