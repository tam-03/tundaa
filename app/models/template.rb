# frozen_string_literal: true

class Template < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :sample, dependent: :destroy
end
