# frozen_string_literal: true

class API::QuestionsController < API::BaseController
  before_action :authenticate_api_user!
  before_action :set_question, only: %i[show update destroy]
  protect_from_forgery except: %i[create update]

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_api_user.id
    if @question.save
      head :created
    else
      head :bad_request
    end
  end

  def show; end

  def update
    if @question.update(question_params)
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @question.destroy
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
