# frozen_string_literal: true

class CreateSubconcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :subconcepts do |t|
      t.integer :ref
      t.string :title, null: false
      t.references :concept, foreign_key: true, index: true

      t.timestamps
    end
  end
end
