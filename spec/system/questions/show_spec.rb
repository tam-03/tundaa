# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question show", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "topにリダイレクトされる", js: true do
      visit questions_path
      expect(current_path).to eq "/login"
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    let(:template) { create(:template) }
    before do
      create(:question, title: "Markdownが分からない", body: "## linkが分からない", user: alice, template_id: template.id)
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "質問一覧"
      click_link "Markdownが分からない"
    end
    scenario "コンテンツが表示されている", js: true do
      expect(page).to have_content("Markdownが分からない")
      expect(page).to have_content("linkが分からない")
    end
    scenario "クリックでコピーができる", js: true do
      find("#markdown_preview").click
      expect(page).to have_content("Markdownをコピーしました")
    end
    scenario "編集ページに遷移できる", js: true do
      question = Question.find_by(title: "Markdownが分からない")
      click_on "編集"
      expect(page).to have_current_path("/questions/#{question.id}/edit/?template=#{template.id}")
      expect(page).to have_content("質問を編集")
    end
    scenario "質問の削除が出来る", js: true do
      click_button "削除"
      click_button "質問一覧"
      expect(page).to_not have_content("Markdownが分からない")
    end
  end
end
