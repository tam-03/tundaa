# frozen_string_literal: true

class API::TemplatesController < API::BaseController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :require_admin_login, except: %i[index show]
  before_action :set_template, only: %i[show update destroy]
  protect_from_forgery except: %i[create update]

  def index
    @templates = Template.all.order(:id)
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      head :created
    else
      head :bad_request
    end
  end

  def show; end

  def update
    if @template.update(template_params)
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @template.destroy
  end

  private
    def template_params
      params.require(:template).permit(:title, :body)
    end

    def set_template
      @template = Template.find(params[:id])
    end
end
