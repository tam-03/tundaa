# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Template New", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "topにリダイレクトされる", js: true do
      visit "/templates/new"
      expect(current_path).to eq "/login"
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
      within "#new_template" do
        click_on "新規作成"
      end
    end
    scenario "テンプレートの新規作成ができる", js: true do
      fill_in "タイトル", with: "全然分からない"
      fill_in "body", with: "## 関連するキーワード"
      click_button "保存"
      expect(page).to have_content("保存しました")
      expect(page).to have_content("全然分からない")
    end
  end
end
