# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Sample show", type: :system do
  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    let(:template) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    before do
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template.id)
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
      click_on "何が分からないか分かっている"
      click_link "例文一覧"
      click_on "Markdownが分からない"
    end
    scenario "コンテンツが表示されている", js: true do
      expect(page).to have_content("Markdownが分からない")
      expect(page).to have_content("linkが分からない")
    end
    scenario "編集ページに遷移できる", js: true do
      click_on "編集"
      sample = Sample.find_by(title: "Markdownが分からない")
      expect(current_path).to eq "/templates/#{sample.template_id}/samples/#{sample.id}/edit"
    end
    scenario "例文の削除が出来る", js: true do
      click_on "削除"
      expect(page).to_not have_content("Markdownが分からない")
    end
  end
end
