# frozen_string_literal: true

class API::BaseController < ApplicationController
  def require_admin_login
    head :unauthorized if !current_api_user.admin
  end
end
