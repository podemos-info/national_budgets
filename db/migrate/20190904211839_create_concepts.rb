class CreateConcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :concepts do |t|
      t.integer :ref
      t.string :title
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
