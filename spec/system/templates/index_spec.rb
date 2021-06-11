# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Template Index", type: :system do
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
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
      visit login_path
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
    end
    scenario "一覧が表示される", js: true do
      expect(page).to have_content("何が分からないか分かっている")
      expect(page).to have_content("何が分からないか分からない")
      expect(page).to have_content("もう何も分からない")
    end
    scenario "新規作成ページに遷移できる", js: true do
      within "#new_template" do
        click_on "新規作成"
      end
      expect(current_path).to eq "/templates/new"
    end
    scenario "編集ページに遷移できる", js: true do
      click_on "何が分からないか分かっている"
      click_button "編集"
      template = Template.find_by(title: "何が分からないか分かっている")
      expect(current_path).to eq "/templates/#{template.id}/edit"
      expect(page).to have_content("テンプレートを編集")
    end
  end
end
