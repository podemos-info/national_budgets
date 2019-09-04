class CreateOrganisms < ActiveRecord::Migration[5.2]
  def change
    create_table :organisms do |t|
      t.integer :ref
      t.string :title
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
