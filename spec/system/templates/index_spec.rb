# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Template Index", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "topにリダイレクトされる", js: true do
      visit templates_path
      expect(current_path).to eq "/login"
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "一覧が表示される", js: true do
      click_button "テンプレート"
      expect(page).to have_content("何が分からないか分かっている")
      expect(page).to have_content("何が分からないか分からない")
      expect(page).to have_content("もう何も分からない")
    end
    scenario "編集ページに遷移できる", js: true do
      click_button "質問一覧"
      template = Template.find_by(title: "Markdownが分からない")
      within ".template-#{template.id}" do
        find("#edit_template_btn").click
      end
      expect(page).to have_content("質問を編集")
    end
  end
end
