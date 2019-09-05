class CreateOrganisms < ActiveRecord::Migration[5.2]
  def change
    create_table :organisms do |t|
      t.integer :ref, null: false
      t.string :title, null: false
      t.references :section, foreign_key: true, null: false

      t.timestamps
    end
  end
end
