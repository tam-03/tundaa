# frozen_string_literal: true

json.samples do
  json.array! @samples do |sample|
    json.partial! "api/samples/sample", sample: sample
  end
end
