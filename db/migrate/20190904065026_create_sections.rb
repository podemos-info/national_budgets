# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.integer :ref, null: false
      t.string :title, null: false
      t.references :budget, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
