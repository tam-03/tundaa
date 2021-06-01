# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "テンプレート1が作成できる", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-1" do
        click_button "作成"
      end
      expect(page).to have_content("テンプレートの内容 1")
    end
    scenario "テンプレート2と3が作成できない", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-2" do
        expect(page).to_not have_content("作成")
      end
      within ".template-3" do
        expect(page).to_not have_content("作成")
      end
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      visit login_path
      expect(current_path).to eq "/login"
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "テンプレート1が作成できる", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-1" do
        click_button "作成"
      end
      expect(page).to have_content("テンプレートの内容 1")
    end
    scenario "テンプレート2が作成できる", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-2" do
        click_button "作成"
      end
      expect(page).to have_content("テンプレートの内容 2")
    end
    scenario "テンプレート3が作成できる", js: true do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-3" do
        click_button "作成"
      end
      expect(page).to have_content("テンプレートの内容 3")
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
      fill_in "email", with: bob.email
      fill_in "password", with: bob.password
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
