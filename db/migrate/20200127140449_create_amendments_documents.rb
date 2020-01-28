# frozen_string_literal: true

class CreateAmendmentsDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :amendments_documents do |t|
      t.references :user, null: false
      t.references :budget, null: false
      t.references :section, null: true
      t.integer :file_type, null: false

      t.timestamps
    end
  end
end
