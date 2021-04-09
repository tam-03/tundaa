# frozen_string_literal: true

class CreateSampleTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :sample_templates do |t|
      t.references :sample, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
