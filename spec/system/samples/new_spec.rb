# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Sample New", type: :system do
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
      fill_in "email", with: bob.email
      fill_in "password", with: bob.password
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
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
      click_on "何が分からないか分かっている"
      click_link "例文一覧"
    end
    scenario "例文の作成と保存が出来る", js: true do
      click_on "新規作成"
      expect(page).to have_content("例文を作成")
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "## Strong Parameterでエラーが出る"
      click_button "保存する"
      expect(page).to have_content("Railsが分からない")
      click_on "Railsが分からない"
      expect(page).to have_content("Strong Parameterでエラーが出る")
    end
  end
end
