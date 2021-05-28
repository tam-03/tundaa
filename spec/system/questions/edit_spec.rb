# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question Edit", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "topにリダイレクトされる", js: true do
      visit questions_path
      expect(current_path).to eq "/login"
    end
  end

  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    before do
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      create(:question, title: "Rubyのif文が分からない", body: "## 条件分岐が分からない\nelseの意味とは?", user: alice)
      question = Question.find_by(title: "Rubyのif文が分からない")
      click_button "質問一覧"
      within ".question-#{question.id}" do
        find("#edit_question_btn").click
      end
    end
    scenario "編集前の質問が表示されている", js: true do
      expect(page).to have_field "タイトル", with: "Rubyのif文が分からない"
      within "#input_area" do
        expect(page).to have_field "body", with: "## 条件分岐が分からない\nelseの意味とは?"
      end
      within "#preview_and_sample_area" do
        expect(page).to have_content("条件分岐が分からない")
        expect(page).to have_content("elseの意味とは?")
      end
    end
    scenario "タイトルの入力が無いと保存ボタンが押せない", js: true do
      find("#title").send_keys [:control, 'A'], :backspace
      expect(page).to have_button "編集を保存する", disabled: true
    end
    scenario "クリックでコピーができる", js: true do
      find("#markdown_preview").click
      expect(page).to have_content("Markdownをコピーしました")
      find("#input_markdown").send_keys [:control, 'A'], :backspace
      expect(page).to_not have_field "body", with: "## 条件分岐が分からない\nelseの意味とは?"
      find("#input_markdown").send_keys [:control, 'V']
      expect(page).to have_field "body", with: "## 条件分岐が分からない\nelseの意味とは?"
    end
    scenario "例文を見れる", js: true do
      visit home_path
      within ".template-1" do
        click_button "作成"
      end
      click_button "例文"
      within "#preview_and_sample_area" do
        expect(page).to have_content("サンプル1")
        expect(page).to have_content("サンプル2")
        expect(page).to have_content("サンプル3")
        expect(page).to have_content("サンプル1内容")
        find(".sample-2").click
        expect(page).to have_content("サンプル2内容")
        find(".sample-3").click
        expect(page).to have_content("サンプル3内容")
        find(".sample-1").click
        expect(page).to have_content("サンプル1内容")
      end
    end
    scenario "質問を編集して保存ができる", js: true do
      fill_in "タイトル", with: "Markdownが分からない"
      fill_in "body", with: "## linkが分からない"
      click_button "編集を保存する"
      expect(page).to have_content("編集を保存しました")
      click_button "質問一覧"
      expect(page).to have_content("Markdownが分からない")
      click_on "Markdownが分からない"
      expect(page).to have_content("linkが分からない")
    end
  end
end
