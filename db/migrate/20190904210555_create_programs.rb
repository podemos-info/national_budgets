class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.string :ref, null: false
      t.string :title, null: false
      t.references :section, foreign_key: true, index: true
      t.references :organism, foreign_key: true, index: true
      t.boolean :is_new, default: false, null: false

      t.timestamps
    end
  end
end
