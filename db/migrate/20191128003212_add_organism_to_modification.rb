# frozen_string_literal: true

class AddOrganismToModification < ActiveRecord::Migration[6.0]
  def change
    add_reference :modifications, :organism, null: true, foreign_key: true, after: :program
  end
end
