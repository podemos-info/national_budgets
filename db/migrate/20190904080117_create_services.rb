class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.integer :ref, null: false
      t.string :title, null: false
      t.references :section, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
