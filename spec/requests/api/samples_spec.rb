# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sample API", type: :request do
  describe "GET api/templates/:template_id/samples" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template_1) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    let(:template_2) { create(:template, title: "何が分からないか分からない", body: "## 作業手順") }
    let(:template_3) { create(:template, title: "もう何も分からない", body: "## ゴール") }
    before do
      create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template_1.id)
      create(:sample, title: "Linuxが分からない", body: "## Permissionのエラーが出る", template_id: template_1.id)
      create(:sample, title: "Rubyが分からない", body: "## 条件分岐が分からない", template_id: template_1.id)
      create(:sample, title: "Javascriptが分からない", body: "## thisが分からない", template_id: template_2.id)
      create(:sample, title: "HTTPが分からない", body: "## PUTとPOSTの違いは？", template_id: template_2.id)
      create(:sample, title: "Railsが分からない", body: "## Strong Parameterが分からない", template_id: template_2.id)
      create(:sample, title: "Gitが分からない", body: "## コミットを直したい", template_id: template_3.id)
      create(:sample, title: "dockerが分からない", body: "## 「-it」とはなんですか？", template_id: template_3.id)
      create(:sample, title: "Vue.jsが分からない", body: "## computedの動きが分からない", template_id: template_3.id)
    end
    context "認証なしのユーザーの場合" do
      it "エラーメッセージを返す" do
        get api_template_samples_path(template_1.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end

    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "サンプルの一覧を取得出来る" do
        get api_template_samples_path(template_1.id), headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res["samples"].count).to eq 3

        sample = res["samples"][0]
        expect(sample["title"]).to eq "Markdownが分からない"

        sample = res["samples"][1]
        expect(sample["title"]).to eq "Linuxが分からない"

        sample = res["samples"][2]
        expect(sample["title"]).to eq "Rubyが分からない"
      end
    end
  end

  describe "POST api/templates/:template_id/samples" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template_1) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    let(:sample) { build(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template_1.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        post api_template_samples_path(template_1.id), params: sample, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "サンプルの新規作成が出来る" do
        expect { post api_template_samples_path(template_1.id), params: sample, headers: auth_tokens, as: :json }.to change { Template.count }.by(1)
        expect(response).to have_http_status(201)

        new_sample = Sample.first
        expect(new_sample.title).to eq "Markdownが分からない"
        expect(new_sample.body).to eq "## linkが分からない"
        expect(new_sample.template_id).to eq template_1.id
      end
    end
  end

  describe "GET api/templates/:template_id/samples/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template_1) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    let(:sample) { create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template_1.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        get api_template_sample_path(template_1.id, sample.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "サンプルを取得出来る" do
        get api_template_sample_path(template_1.id, sample.id), headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq "Markdownが分からない"
        expect(res["body"]).to eq "## linkが分からない"
        expect(res["template_id"]).to eq template_1.id
      end
    end
  end

  describe "PATCH api/templates/:template_id/samples/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template_1) { create(:template, title: "何が分からないか分かっている", body: "## 困っていること") }
    let(:sample) { create(:sample, title: "Markdownが分からない", body: "## linkが分からない", template_id: template_1.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        patch api_template_sample_path(template_1.id, sample.id), params: { title: "Linuxが分からない", body: "## Permissionのエラーが出る" }, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "テンプレートの編集が出来る" do
        patch api_template_sample_path(template_1.id, sample.id), params: { title: "Linuxが分からない", body: "## Permissionのエラーが出る" }, headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        edit_sample = Sample.find(sample.id)
        expect(edit_sample.title).to eq "Linuxが分からない"
        expect(edit_sample.body).to eq "## Permissionのエラーが出る"
      end
    end
  end
end
