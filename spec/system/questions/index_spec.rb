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
    let(:template) { create(:template) }
    before do
      create(:question, title: "Markdownが分からない", user: alice, template_id: template.id)
      create(:question, title: "Linuxが分からない", user: alice, template_id: template.id)
      create(:question, title: "Railsが分からない", user: alice, template_id: template.id)
      create(:question, title: "Javascriptが分からない", user: alice, template_id: template.id)
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
    scenario "個別ページに遷移できる", js: true do
      click_button "質問一覧"
      click_link "Markdownが分からない"
      expect(page).to have_content("Markdownが分からない")
    end
    scenario "編集ページに遷移できる", js: true do
      click_button "質問一覧"
      question = Question.find_by(title: "Markdownが分からない")
      within ".question-#{question.id}" do
        find("#edit_question_btn").click
      end
      expect(page).to have_content("質問を編集")
    end
  end
end
