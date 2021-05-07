# frozen_string_literal: true

require "rails_helper"

RSpec.feature "アカウント登録", type: :system do
  scenario "画面表示を確認", js: true do
    visit sign_up_path
    expect(current_path).to eq "/sign_up"
    expect(page).to have_content "登録"
  end
end
