# frozen_string_literal: true

class AddTerritoryToAmendments < ActiveRecord::Migration[6.0]
  def change
    add_reference :amendments, :territory, null: true, foreign_key: true
  end
end
