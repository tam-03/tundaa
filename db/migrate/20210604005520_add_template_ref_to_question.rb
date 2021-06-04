# frozen_string_literal: true

class AddTemplateRefToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :template, foreign_key: true
  end
end
