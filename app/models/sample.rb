# frozen_string_literal: true

class Sample < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :sample_templates
  has_many :templates, through: :sample_templates
end
