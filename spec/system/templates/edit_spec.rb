# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Template Edit", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "homeにリダイレクトされる", js: true do
      visit templates_path
      expect(current_path).to eq "/home"
    end
  end
  context "認証ありのユーザーの場合" do
    let(:bob) { create(:user, email: "bob@example.com", password: "testtest") }
    before do
      visit login_path
      fill_in "メールアドレス", with: bob.email
      fill_in "パスワード", with: bob.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "homeにリダイレクトされる", js: true do
      visit templates_path
      expect(current_path).to eq "/home"
    end
  end
  context "管理者の場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest", admin: true) }
    before do
      visit login_path
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
      click_button "テンプレート"
      click_on "何が分からないか分かっている"
      click_button "編集"
    end
    scenario "編集前のテンプレートが表示されている", js: true do
      expect(page).to have_field "タイトル", with: "何が分からないか分かっている"
      expect(page).to have_field "body", with: "## 困っていること"
    end
    scenario "テンプレートを編集して保存ができる", js: true do
      fill_in "タイトル", with: "全然分からない"
      find("#edit_template").send_keys [:control, "A"], :backspace
      fill_in "body", with: "## 関連するキーワード"
      click_button "保存"
      expect(page).to have_content("編集を保存しました")
      expect(page).to have_content("全然分からない")
    end
    scenario "テンプレートの削除ができる", js: true do
      click_button "削除"
      expect(page).to_not have_content("何が分からないか分かっている")
    end
  end
end
