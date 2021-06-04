# frozen_string_literal: true

class AddFreeToTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :templates, :free, :boolean, null: false, default: false
  end
end
