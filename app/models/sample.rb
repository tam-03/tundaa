# frozen_string_literal: true

class Sample < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :template_id, presence: true

  belongs_to :template
end
