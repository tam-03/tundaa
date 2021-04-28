# frozen_string_literal: true

class API::QuestionsController < API::BaseController
  def index
    @question = Question.all
  end

  def create
    puts '------通過--------'
    # current_userの情報が出るか確認
    # puts current_user
    # @question = Question.new(question_params)
    # @question.user_id = current_user.id
  end

  def show
    render json: Question.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
