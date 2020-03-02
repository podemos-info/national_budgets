# frozen_string_literal: true

class AddUniqueIndexToAmendmentNumber < ActiveRecord::Migration[6.0]
  def change
    add_index :amendments, %i[budget_id number], unique: true
  end
end
