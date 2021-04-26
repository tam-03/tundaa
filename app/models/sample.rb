# frozen_string_literal: true

class Sample < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :template_id
end
