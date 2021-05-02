# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Question_API", type: :request do
  describe "GET api/questions" do
    let(:user) { create(:user) }
    before do
      create_list(:question, 10, user_id: user.id)
    end
    context "認証無しのユーザーの場合" do
      subject { get api_questions_path, as: :json }
      it "401を返す" do
        subject
        expect(response).to have_http_status(401)
      end
      it "質問の一覧を取得出来ない" do
        subject
        res = JSON.parse(response.body).keys
        expect(res[0]).to eq "errors"
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { user.create_new_auth_token }
      subject { get api_questions_path, headers: auth_tokens, as: :json }
      it "200を返す" do
        subject
        expect(response).to have_http_status(200)
      end
      it "質問の一覧を取得出来る" do
        subject
        res = JSON.parse(response.body)
        expect(res["questions"].count).to eq 10
      end
    end
  end

  describe "POST api/questions" do
    let(:user) { create(:user) }
    let(:question) { build(:question) }
    context "認証無しのユーザーの場合" do
      subject { post api_questions_path, params: question, as: :json }
      it "401を返す" do
        subject
        expect(response).to have_http_status(401)
      end
      it "質問を新規作成出来ない" do
        subject
        res = JSON.parse(response.body).keys
        expect(res[0]).to eq "errors"
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { user.create_new_auth_token }
      subject { post api_questions_path, params: question, headers: auth_tokens, as: :json }
      it "201を返す" do
        subject
        expect(response).to have_http_status(201)
      end
      it "質問を新規作成出来る" do
        expect { subject }.to change { Question.count }.by(1)
      end
    end
  end

  describe "GET api/questions/:id" do
    let(:user) { create(:user) }
    let(:question) { create(:question, user_id: user.id) }
    context "認証無しのユーザーの場合" do
      subject { get api_question_path(question.id), as: :json }
      it "401を返す" do
        subject
        expect(response).to have_http_status(401)
      end
      it "質問を取得できない" do
        subject
        res = JSON.parse(response.body).keys
        expect(res[0]).to eq "errors"
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { user.create_new_auth_token }
      subject { get api_question_path(question.id), headers: auth_tokens, as: :json }
      it "200を返す" do
        subject
        expect(response).to have_http_status(200)
      end
      it "質問を取得出来る" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq question.id
      end
    end
  end

  describe "PATCH api/questions/:id" do
    let(:user) { create(:user) }
    let(:question) { create(:question, user_id: user.id) }
    context "認証無しのユーザーの場合" do
      subject { patch api_question_path(question.id), params: { title: "テスト1を編集", body: "編集" }, as: :json }
      it "401を返す" do
        subject
        expect(response).to have_http_status(401)
      end
      it "質問を編集できない" do
        subject
        res = JSON.parse(response.body).keys
        expect(res[0]).to eq "errors"
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { user.create_new_auth_token }
      subject { patch api_question_path(question.id), params: { title: "テストの編集" }, headers: auth_tokens, as: :json }
      it "200を返す" do
        subject
        expect(response).to have_http_status(200)
      end
      it "質問の編集が出来る" do
        expect { subject }.to change { Question.find(question.id).title }.from(question.title).to("テストの編集")
      end
    end
  end

  describe "DELETE api/questions/:id" do
    let(:user) { create(:user) }
    let(:question) { create(:question, user_id: user.id) }
    context "認証無しのユーザーの場合" do
      subject { delete api_question_path(question.id), as: :json }
      it "401を返す" do
        subject
        expect(response).to have_http_status(401)
      end
      it "質問を削除出来ない" do
        subject
        res = JSON.parse(response.body).keys
        expect(res[0]).to eq "errors"
      end
    end
    context "認証有りのユーザーの場合" do
      let(:auth_tokens) { user.create_new_auth_token }
      subject { delete api_question_path(question.id), headers: auth_tokens, as: :json }
      it "204を返す" do
        subject
        expect(response.status).to eq 204
      end
      it "質問を削除出来る" do
        expect { subject }.to change { Question.count }.by(0)
      end
    end
  end
end
