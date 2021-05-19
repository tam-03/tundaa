# frozen_string_literal: true

json.templates do
  json.array! @templates do |template|
    json.partial! "api/templates/template", template: template
  end
end
