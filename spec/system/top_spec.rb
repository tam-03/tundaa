# frozen_string_literal: true

require "rails_helper"

RSpec.feature "top", type: :system do
  context "認証無しのユーザーの場合" do
    scenario "トップページはwelcomeになる", js: true do
      visit root_path
      expect(current_path).to eq "/"
      expect(page).to have_content "welcome"
    end
  end
  context "認証有りのユーザーの場合" do
    let(:user) { create(:user, email: "test@example.com", password: "testtest") }
    before do
      visit login_path
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "testtest"
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "トップページから/homeリダイレクトされる", js: true do
      visit root_path
      pending "更新してもtokenを持つ様に設定する"
      expect(current_path).to eq home_path
      expect(page).to have_content "質問を作成する"
    end
  end
end
