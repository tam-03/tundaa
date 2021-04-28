# frozen_string_literal: true

class API::QuestionsController < API::BaseController
  def index
    render json: Question.all
  end

  def create
    # @question = Question.new(question_params)
  end

  def show
    render json: Question.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def question_params
  end
end
