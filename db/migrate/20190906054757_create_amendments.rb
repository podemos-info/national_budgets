# frozen_string_literal: true

class CreateAmendments < ActiveRecord::Migration[5.2]
  def change
    create_table :amendments do |t|
      t.string :number
      t.string :type
      t.text :explanation
      t.references :user, foreign_key: true
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
