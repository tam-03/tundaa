# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Question API", type: :request do
  describe "GET api/questions" do
    let(:alice) { create(:user, name: "Alice") }
    let(:bob) { create(:user, name: "bob") }
    let(:template) { create(:template) }
    before do
      create(:question, title: "Markdownが分からない", user: alice, template_id: template.id)
      create(:question, title: "Linuxが分からない", user: alice, template_id: template.id)
      create(:question, title: "Railsが分からない", user: alice, template_id: template.id)
      create(:question, title: "Javascriptが分からない", user: bob, template_id: template.id)
    end
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        get api_questions_path, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "質問の一覧を取得出来る" do
        get api_questions_path, headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res["questions"].count).to eq 3

        question = res["questions"][0]
        expect(question["title"]).to eq "Railsが分からない"
        expect(question["user_id"]).to eq alice.id
        expect(question["template_id"]).to eq template.id

        question = res["questions"][1]
        expect(question["title"]).to eq "Linuxが分からない"
        expect(question["user_id"]).to eq alice.id
        expect(question["template_id"]).to eq template.id

        question = res["questions"][2]
        expect(question["title"]).to eq "Markdownが分からない"
        expect(question["user_id"]).to eq alice.id
        expect(question["template_id"]).to eq template.id
      end
    end
  end

  describe "POST api/questions" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template) }
    let(:question) { build(:question, title: "Markdownが分からない", body: "## linkが分からない", user: alice, template_id: template.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        post api_questions_path, params: question, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "質問を新規作成出来る" do
        expect { post api_questions_path, params: question, headers: auth_tokens, as: :json }.to change { Question.count }.by(1)
        expect(response).to have_http_status(201)

        new_question = Question.first
        expect(new_question.title).to eq "Markdownが分からない"
        expect(new_question.body).to eq "## linkが分からない"
        expect(new_question.user_id).to eq alice.id
        expect(new_question.template_id).to eq template.id
      end
    end
  end

  describe "GET api/questions/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template) }
    let(:question) { create(:question, title: "Linuxが分からない", user: alice, template_id: template.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        get api_question_path(question.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "質問を取得出来る" do
        get api_question_path(question.id), headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res["title"]).to eq "Linuxが分からない"
      end
    end
  end

  describe "PATCH api/questions/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template) }
    let(:question) { create(:question, title: "Railsが分からない", body: "## 条件分岐が分からない", user: alice, template_id: template.id) }
    context "認証無しのユーザーの場合" do
      it "エラーメッセージを返す" do
        patch api_question_path(question.id), params: { title: "Railsのif文が分からない", body: "## elseの意味とは?" }, as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "質問の編集が出来る" do
        patch api_question_path(question.id), params: { title: "Railsのif文が分からない", body: "## elseの意味とは?" }, headers: auth_tokens, as: :json
        expect(response).to have_http_status(200)

        edit_question = Question.find(question.id)
        expect(edit_question.title).to eq "Railsのif文が分からない"
        expect(edit_question.body).to eq "## elseの意味とは?"
        expect(edit_question.user_id).to eq alice.id
        expect(edit_question.template_id).to eq template.id
      end
    end
  end

  describe "DELETE api/questions/:id" do
    let(:alice) { create(:user, name: "Alice") }
    let(:template) { create(:template) }
    let(:delete_question) { create(:question, title: "Javascriptが分からない", user: alice, template_id: template.id) }
    before do
      create(:question, title: "Markdownが分からない", user: alice, template_id: template.id)
      create(:question, title: "Linuxが分からない", user: alice, template_id: template.id)
      create(:question, title: "Railsが分からない", user: alice, template_id: template.id)
    end
    # let(:question) { create(:question, title: "Javascriptが分からない", user: alice, template_id: template.id) }
    context "認証無しのユーザーの場合" do
      it "質問を削除出来ない" do
        delete api_question_path(delete_question.id), as: :json
        expect(response).to have_http_status(401)
        json = JSON.parse(response.body)
        expect(json).to eq "errors" => ["You need to sign in or sign up before continuing."]
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { alice.create_new_auth_token }
      it "質問を削除出来る" do
        delete api_question_path(delete_question.id), headers: auth_tokens, as: :json
        expect(response.status).to eq 204
        expect(Question.count).to eq 3
      end
    end
  end
end
