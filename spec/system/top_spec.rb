# frozen_string_literal: true

require "rails_helper"

RSpec.feature "top", type: :system do
  context "認証無しのユーザーの場合" do
    scenario "トップページはwelcomeになる", js: true do
      visit root_path
      expect(current_path).to eq "/"
    end
  end
  context "認証有りのユーザーの場合" do
    let(:user) { create(:user) }
    before do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "トップページから/homeリダイレクトされる", js: true do
      expect(page).to have_content "ログインしました"
      visit root_path
      expect(current_path).to eq home_path
      expect(page).to have_content "あなたの状態に近いものはどれ？"
    end
  end
end
