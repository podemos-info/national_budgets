# frozen_string_literal: true

class CreateTerritories < ActiveRecord::Migration[6.0]
  def change
    create_table :territories do |t|
      t.string :type, null: false
      t.integer :territory_id, null: false
      t.string :iso, null: false
      t.string :name, null: false
      t.integer :parent_id, null: true, foreign_key: true, index: true

      t.timestamps
    end
  end
end
