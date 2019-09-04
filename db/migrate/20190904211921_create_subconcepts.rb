class CreateSubconcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :subconcepts do |t|
      t.integer :ref
      t.string :title
      t.references :concept, foreign_key: true

      t.timestamps
    end
  end
end
