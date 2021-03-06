# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Sample Edit", type: :system do
  context "認証なしのユーザーの場合" do
    scenario "homeにリダイレクトされる", js: true do
      visit templates_path
      expect(current_path).to eq "/home"
    end
  end
  context "認証ありのユーザーの場合" do
    let(:bob) { create(:user, email: "bob@example.com", password: "testtest") }
    before do
      visit login_path
      fill_in "メールアドレス", with: bob.email
      fill_in "パスワード", with: bob.password
      within "#login" do
        click_button "ログイン"
      end
    end
    scenario "homeにリダイレクトされる", js: true do
      visit templates_path
      expect(current_path).to eq "/home"
    end
  end
  context "管理者の場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest", admin: true) }
    let(:template) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    let(:sample) { Sample.find_by(title: "Markdownが分からない") }
    before do
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template.id)
      visit login_path
      fill_in "メールアドレス", with: alice.email
      fill_in "パスワード", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
      click_on "何が分からないか分かっている"
      click_link "例文一覧"
      within ".sample-#{sample.id}" do
        find("#edit_sample_btn").click
      end
    end
    scenario "編集前の例文が表示されている", js: true do
      expect(current_path).to eq "/templates/#{sample.template_id}/samples/#{sample.id}/edit"
      expect(page).to have_field "タイトル", with: "Markdownが分からない"
      within "#input_area" do
        expect(page).to have_field "body", with: "## linkが分からない"
      end
      within "#preview_and_sample_area" do
        expect(page).to have_content("linkが分からない")
      end
    end
    scenario "例文を編集して保存ができる", js: true do
      fill_in "タイトル", with: "Railsが分からない"
      fill_in "body", with: "## Strong Parameterでエラーが出る"
      click_button "編集を保存する"
      expect(page).to have_content("編集を保存しました")
      expect(page).to have_content("Railsが分からない")
      expect(current_path).to eq "/templates/#{sample.template_id}/samples"
      click_on "Railsが分からない"
      expect(page).to have_content("Railsが分からない")
      expect(page).to have_content("Strong Parameterでエラーが出る")
    end
  end
end
