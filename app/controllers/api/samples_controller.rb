# frozen_string_literal: true

class API::SamplesController < API::BaseController
  before_action :authenticate_api_user!
  before_action :require_admin_login, except: %i[index show]
  before_action :set_sample, only: %i[show update destroy]
  protect_from_forgery except: %i[create update]

  def index
    @samples = template.sample.all
  end

  def create
    @sample = Sample.new(sample_params)
    if @sample.save
      head :created
    else
      head :bad_request
    end
  end

  def show; end

  def update
    if @sample.update(sample_params)
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @sample.destroy
  end

  private
    def sample_params
      params.require(:sample).permit(:title, :body, :template_id)
    end

    def set_sample
      @sample = Sample.find(params[:id])
    end

    def template
      Template.find(params[:template_id])
    end
end
