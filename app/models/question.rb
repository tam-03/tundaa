# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user_id
  belongs_to :template_id
end
