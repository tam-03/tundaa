# frozen_string_literal: true

json.questions do
  json.array! @questions do |question|
    json.partial! "api/questions/question", question: question
  end
end
