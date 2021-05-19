# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Template API", type: :request do
  describe "GET api/templates" do
    before do
      create(:template, title: "テンプレート1", body: "テンプレート1の内容")
      create(:template, title: "テンプレート2", body: "テンプレート2の内容")
      create(:template, title: "テンプレート3", body: "テンプレート3の内容")
    end
    it "テンプレートの一覧が取得できる" do
      get api_templates_path, as: :json
      expect(response).to have_http_status(200)

      res = JSON.parse(response.body)
      expect(res["templates"].count).to eq 3

      template = res["templates"][0]
      expect(template["title"]).to eq "テンプレート1"
      expect(template["body"]).to eq "テンプレート1の内容"

      template = res["templates"][1]
      expect(template["title"]).to eq "テンプレート2"
      expect(template["body"]).to eq "テンプレート2の内容"

      template = res["templates"][2]
      expect(template["title"]).to eq "テンプレート3"
      expect(template["body"]).to eq "テンプレート3の内容"
    end
  end
end
