# frozen_string_literal: true

class API::TemplatesController < API::BaseController

  def index
    @templates = Template.all
  end

end
