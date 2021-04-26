# frozen_string_literal: true

class Template < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :sample_id
end
