# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question Index", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "topにリダイレクトされる", js: true do
      visit questions_path
      expect(current_path).to eq "/login"
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      create(:question, title: "Markdownが分からない", user: alice)
      create(:question, title: "Linuxが分からない", user: alice)
      create(:question, title: "Railsが分からない", user: alice)
      create(:question, title: "Javascriptが分からない", user: alice)
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "一覧が表示される", js: true do
      click_button "質問一覧"
      expect(page).to have_content("Markdownが分からない")
      expect(page).to have_content("Linuxが分からない")
      expect(page).to have_content("Railsが分からない")
      expect(page).to have_content("Javascriptが分からない")
    end
  end
end
