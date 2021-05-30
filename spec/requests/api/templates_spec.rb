# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Template API", type: :request do
  describe "GET api/templates" do
    let(:alice) { create(:user, name: "Alice") }
    before do
      create(:template, title: "何が分からないか分かっている", body: "## 困っていること")
      create(:template, title: "何が分からないか分からない", body: "## 作業手順")
      create(:template, title: "もう何も分からない", body: "## ゴール")
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートの一覧を取得出来る" do
        get api_templates_path, headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res["templates"].count).to eq 3

        template = res["templates"][0]
        expect(template["title"]).to eq "何が分からないか分かっている"

        template = res["templates"][1]
        expect(template["title"]).to eq "何が分からないか分からない"

        template = res["templates"][2]
        expect(template["title"]).to eq "もう何も分からない"
      end
    end
  end

  describe "POST api/templates" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { build(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        post api_templates_path, params: template, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートの新規作成が出来る" do
        expect { post api_templates_path, params: template, headers: auth_tokens, as: :json }.to change { Template.count }.by(1)
        expect(response).to have_http_status(201)

        new_template = Template.first
        expect(new_template.title).to eq "何が分からないか分かっている"
        expect(new_template.body).to eq "## 困っていること"
      end
    end
  end

  describe "GET api/templates/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template, title: "何が分からないか分からない") }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        get api_template_path(template.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートを取得出来る" do
        get api_template_path(template.id), headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res["title"]).to eq "何が分からないか分からない"
      end
    end
  end

  describe "PATCH api/templates/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template, title: "もう何も分からない", body: "## ゴール") }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        patch api_template_path(template.id), params: { title: "何が分からないか分かっている", body: "## 困っていること" }, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートの編集が出来る" do
        patch api_template_path(template.id), params: { title: "何が分からないか分かっている", body: "## 困っていること" }, headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        edit_template = Template.find(template.id)
        expect(edit_template.title).to eq "何が分からないか分かっている"
        expect(edit_template.body).to eq "## 困っていること"
      end
    end
  end

  describe "DELETE api/templates/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:delete_template) { create(:template, title: "全然分からない") }
    before do
      create(:template, title: "何が分からないか分かっている")
      create(:template, title: "何が分からないか分からない")
      create(:template, title: "もう何も分からない")
    end
    context "認証無しのユーザーの場合" do
      it "テンプレートを削除出来ない" do
        delete api_template_path(delete_template.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートを削除出来る" do
        delete api_template_path(delete_template.id), headers: auth_tokens, as: :json
        expect(response.status).to eq 204
        expect(Template.count).to eq 3
      end
    end
  end
end
