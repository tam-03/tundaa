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
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      template = Template.find_by(title: "何が分からないか分かっている")
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template.id)
      create(:sample, title: "Linuxが分からない", body: "## パーミッションエラーが出る", template_id: template.id)
      create(:sample, title: "Railsが分からない", body: "## Strong Parameterでエラーが出る", template_id: template.id)
      create(:question, title: "Rubyのif文が分からない", body: "## 条件分岐が分からない\nelseの意味とは?", user: alice, template_id: template.id)
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
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
      find("#title").send_keys [:control, "A"], :backspace
      expect(page).to have_button "編集を保存する", disabled: true
    end
    scenario "クリックでコピーができる", js: true do
      find("#markdown_preview").click
      expect(page).to have_content("Markdownをコピーしました")
      find("#input_markdown").send_keys [:control, "A"], :backspace
      expect(page).to_not have_field "body", with: "## 条件分岐が分からない\nelseの意味とは?"
      find("#input_markdown").send_keys [:control, "V"]
      expect(page).to have_field "body", with: "## 条件分岐が分からない\nelseの意味とは?"
    end
    scenario "例文を見れる", js: true do
      sample_1 = Sample.find_by(title: "Markdownが分からない")
      sample_2 = Sample.find_by(title: "Linuxが分からない")
      sample_3 = Sample.find_by(title: "Railsが分からない")
      click_button "例文"
      within "#preview_and_sample_area" do
        expect(page).to have_content("Markdownが分からない")
        expect(page).to have_content("linkが分からない")
        find(".sample-#{sample_2.id}").click
        expect(page).to have_content("Linuxが分からない")
        expect(page).to have_content("パーミッションエラーが出る")
        find(".sample-#{sample_3.id}").click
        expect(page).to have_content("Railsが分からない")
        expect(page).to have_content("Strong Parameterでエラーが出る")
        find(".sample-#{sample_1.id}").click
        expect(page).to have_content("Markdownが分からない")
        expect(page).to have_content("linkが分からない")
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
