# frozen_string_literal: true

json.id question.id
json.title question.title
json.body question.body
json.user_id question.user_id
json.template_id question.template_id
json.url "/questions/#{question.id}"
json.editUrl "/questions/#{question.id}/edit"
