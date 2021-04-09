# frozen_string_literal: true

class Template < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :sample_templates
  has_many :samples, through: :sample_templates
end
