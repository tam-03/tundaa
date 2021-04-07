# frozen_string_literal: true

class AddColumsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, null: false, default: ""
  end
end
