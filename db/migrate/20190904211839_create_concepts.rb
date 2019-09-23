# frozen_string_literal: true

class CreateConcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :concepts do |t|
      t.integer :ref
      t.string :title, null: false
      t.references :article, foreign_key: true, index: true

      t.timestamps
    end
  end
end
