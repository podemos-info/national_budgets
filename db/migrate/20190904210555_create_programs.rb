class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.string :ref, null: false
      t.string :title, null: false
      t.references :section, foreign_key: true, index: true

      t.timestamps
    end
  end
end
