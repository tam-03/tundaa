# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  belongs_to :template
end
