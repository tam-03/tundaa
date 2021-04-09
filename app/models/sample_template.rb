# frozen_string_literal: true

class SampleTemplate < ApplicationRecord
  belongs_to :sample
  belongs_to :template
end
