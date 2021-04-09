# frozen_string_literal: true

class CreateSamples < ActiveRecord::Migration[6.1]
  def change
    create_table :samples do |t|
      t.string :title, null: false, default: ""
      t.text :body, null: false, default: ""

      t.timestamps
    end
  end
end
