# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question New", type: :system do
  context "認証なし&認証ありのユーザーの場合" do
    before do
      visit home_path
      expect(page).to have_content("質問を作成する")
      within ".template-1" do
        click_button "作成"
      end
    end
    scenario "textareaにMarkdownを入力するとプレビューされる", js: true do
      expect(current_path).to eq "/questions/new"
      fill_in "body", with: "## テスト"
      within "#preview_and_sample_area" do
        expect(page).to have_content("テスト")
      end
    end
    scenario "タイトルの入力が無いと保存ボタンが押せない", js: true do
      fill_in "タイトル", with: ""
      expect(page).to have_button "保存する", disabled: true
    end
    scenario "クリックでコピーができる", js: true do
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "## Parameterでエラーが出る"
      find("#markdown_preview").click
      expect(page).to have_content("Markdownをコピーしました")
      find("#input_markdown").send_keys [:control, 'A'], :backspace
      expect(page).to_not have_field "body", with: "## Parameterでエラーが出る"
      find("#input_markdown").send_keys [:control, 'V']
      expect(page).to have_field "body", with: "## Parameterでエラーが出る"
    end
  end

  context "認証なしのユーザーの場合" do
    before do
      visit home_path
      within ".template-1" do
        click_button "作成"
      end
    end
    scenario "保存ができない", js: true do
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "Strong Parameterでエラーが出る"
      expect(page).to have_button "保存する", disabled: true
      expect(page).to have_content("会員登録をすると保存が出来ます")
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
    end
    scenario "テンプレート1を使った作成と保存が出来る", js: true do
      visit home_path
      within ".template-1" do
        click_button "作成"
      end
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "Strong Parameterでエラーが出る"
      click_button "保存する"
      expect(page).to have_content("保存しました")
      click_button "質問一覧"
      expect(page).to have_content("Railsが分からない")
    end
    scenario "テンプレート2を使った作成と保存が出来る", js: true do
      visit home_path
      within ".template-2" do
        click_button "作成"
      end
      fill_in "タイトル", with: "Markdownが分からない"
      fill_in "body", with: "折りたたみを表現する方法が分からない"
      click_button "保存する"
      expect(page).to have_content("保存しました")
      click_button "質問一覧"
      expect(page).to have_content("Markdownが分からない")
    end
    scenario "テンプレート3を使った作成と保存が出来る", js: true do
      visit home_path
      within ".template-3" do
        click_button "作成"
      end
      fill_in "タイトル", with: "Linuxが分からない"
      fill_in "body", with: "パーミッションエラーが出る"
      click_button "保存する"
      expect(page).to have_content("保存しました")
      click_button "質問一覧"
      expect(page).to have_content("Linuxが分からない")
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
  end
end
