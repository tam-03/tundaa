# frozen_string_literal: true

require "rails_helper"

RSpec.feature "User", type: :system do
  scenario "登録", js: true do
    visit "/sign_up"
    expect(current_path).to eq "/sign_up"
    fill_in "メールアドレス", with: "alice@example.com"
    fill_in "パスワード", with: "testtest"
    fill_in "パスワード(確認用)", with: "testtest"
    within "#register" do
      click_button "登録"
    end
    expect(page).to have_content("アカウント登録が完了しました")
  end
  context "ログイン" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    scenario "ログイン", js: true do
      visit login_path
      expect(current_path).to eq "/login"
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      expect(page).to have_content("ログインしました")
    end
  end
  context "GitHubログイン" do
    before do
      github_mock
    end
    scenario "ログイン後にhomeにリダイレクトされる", js: true do
      visit login_path
      within "#login" do
        click_on "GitHubでログイン"
      end
      sleep 1
      visit current_path
      expect(current_path).to eq "/home"
      expect(page).to have_content("ログインしました")
      github_login_user = User.find_by(provider: "github")
      expect(github_login_user.uid).to eq "123545"
    end
  end
  context "Googleログイン" do
    before do
      google_mock
    end
    scenario "ログイン後にhomeにリダイレクトされる", js: true do
      visit login_path
      within "#login" do
        click_on "Googleでログイン"
      end
      sleep 1
      visit current_path
      expect(current_path).to eq "/home"
      expect(page).to have_content("ログインしました")
      google_login_user = User.find_by(provider: "google_oauth2")
      expect(google_login_user.uid).to eq "123545"
    end
  end
end
