# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Sample Index", type: :system do
  context "認証ありのユーザーの場合" do
    let(:alice) { create(:user, email: "alice@example.com", password: "testtest") }
    let(:template) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    before do
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template.id)
      create(:sample, title: "Linuxが分からない", body: "## パーミッションエラーが出る", template_id: template.id)
      create(:sample, title: "Railsが分からない", body: "## Strong Parameterでエラーが出る", template_id: template.id)
      visit login_path
      fill_in "email", with: alice.email
      fill_in "password", with: alice.password
      within "#login" do
        click_button "ログイン"
      end
      click_button "テンプレート"
      click_on "何が分からないか分かっている"
      click_link "例文一覧"
    end
    scenario "一覧が表示される", js: true do
      expect(page).to have_content("Markdownが分からない")
      expect(page).to have_content("Linuxが分からない")
      expect(page).to have_content("Railsが分からない")
    end
    scenario "個別ページに遷移できる", js: true do
      sample = Sample.find_by(title: "Markdownが分からない")
      click_on "Markdownが分からない"
      expect(current_path).to eq "/templates/#{template.id}/samples/#{sample.id}"
    end
    scenario "編集ページに遷移できる", js: true do
      sample = Sample.find_by(title: "Markdownが分からない")
      within ".sample-#{sample.id}" do
        find("#edit_sample_btn").click
      end
      expect(current_path).to eq "/templates/#{template.id}/samples/#{sample.id}/edit"
    end
  end
end
