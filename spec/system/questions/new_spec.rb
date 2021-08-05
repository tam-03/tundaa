# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question New", type: :system do
  context "認証なし&認証ありのユーザーの場合" do
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること", free: true)
      template = Template.find_by(title: "何が分からないか分かっている")
      visit home_path
      within ".template-#{template.id}" do
        click_button "作成"
      end
    end
    scenario "URLにテンプレートidのクエリが付与されている", js: true do
      template = Template.find_by(title: "何が分からないか分かっている")
      expect(page).to have_current_path("/questions/new/?template=#{template.id}")
    end
    scenario "textareaにMarkdownを入力するとプレビューされる", js: true do
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
      find("#input_markdown").send_keys [:control, "A"], :backspace
      expect(page).to_not have_field "body", with: "## Parameterでエラーが出る"
      find("#input_markdown").send_keys [:control, "V"]
      expect(page).to have_field "body", with: "## Parameterでエラーが出る"
    end
  end

  context "認証なしのユーザーの場合" do
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること", free: true)
      template = Template.find_by(title: "何が分からないか分かっている")
      visit home_path
      within ".template-#{template.id}" do
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
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      template = Template.find_by(title: "何が分からないか分かっている")
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template.id)
      create(:sample, title: "Linuxが分からない", body: "## パーミッションエラーが出る", template_id: template.id)
      create(:sample, title: "Railsが分からない", body: "## Strong Parameterでエラーが出る", template_id: template.id)
      visit login_path
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      visit home_path
      within ".template-#{template.id}" do
        click_button "作成"
      end
    end
    scenario "テンプレート1を使った作成と保存が出来る", js: true do
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "Strong Parameterでエラーが出る"
      click_button "保存する"
      expect(page).to have_content("保存しました")
      click_button "質問一覧"
      expect(page).to have_content("Railsが分からない")
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
  end
end
