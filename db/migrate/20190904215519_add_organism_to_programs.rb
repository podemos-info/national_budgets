# frozen_string_literal: true

class AddOrganismToPrograms < ActiveRecord::Migration[5.2]
  def change
    add_reference :programs, :organism, foreign_key: true, index: true
  end
end
