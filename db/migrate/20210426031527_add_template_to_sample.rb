class AddTemplateToSample < ActiveRecord::Migration[6.1]
  def change
    add_reference :samples, :template, null: false, foreign_key: true
  end
end
