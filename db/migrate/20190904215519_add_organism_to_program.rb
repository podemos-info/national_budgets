class AddOrganismToProgram < ActiveRecord::Migration[5.2]
  def change
    add_reference :programs, :organism, foreign_key: true, index: true
  end
end
