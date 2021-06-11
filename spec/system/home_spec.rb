# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home", type: :system do
  context "認証なしのユーザーの場合" do
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること", free: true)
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
    end
    scenario "テンプレート1が作成できる", js: true do
      template_1 = Template.find_by(title: "何が分からないか分かっている")
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-#{template_1.id}" do
        click_button "作成"
      end
      expect(page).to have_content("困っていること")
    end
    scenario "テンプレート2と3が作成できない", js: true do
      template_2 = Template.find_by(title: "何が分からないか分からない")
      template_3 = Template.find_by(title: "もう何も分からない")
      visit home_path
      within ".template-#{template_2.id}" do
        expect(page).to_not have_content("作成")
      end
      within ".template-#{template_3.id}" do
        expect(page).to_not have_content("作成")
      end
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること", free: true)
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
      visit login_path
      expect(current_path).to eq "/login"
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "テンプレート1が作成できる", js: true do
      template_1 = Template.find_by(title: "何が分からないか分かっている")
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-#{template_1.id}" do
        click_button "作成"
      end
      expect(page).to have_content("困っていること")
    end
    scenario "テンプレート2が作成できる", js: true do
      template_2 = Template.find_by(title: "何が分からないか分からない")
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-#{template_2.id}" do
        click_button "作成"
      end
      expect(page).to have_content("作業手順")
    end
    scenario "テンプレート3が作成できる", js: true do
      template_3 = Template.find_by(title: "もう何も分からない")
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-#{template_3.id}" do
        click_button "作成"
      end
      expect(page).to have_content("ゴール")
    end
    scenario "テンプレート一覧に遷移できない", js: true do
      visit home_path
      expect(page).to_not have_content("テンプレート一覧")
      visit templates_path
      expect(current_path).to eq "/home"
    end
  end

  context "管理者の場合" do
    let(:bob) { create(:user, email: "alice@example.com", password: "testtest", admin: true) }
    before do
      visit login_path
      expect(current_path).to eq "/login"
      fill_in "メールアドレス", with: bob.email
      fill_in "パスワード", with: bob.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "テンプレート一覧が見れる", js: true do
      visit home_path
      click_button "テンプレート一覧"
      expect(current_path).to eq "/templates"
    end
  end
end
