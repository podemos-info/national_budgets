class CreateArticulateds < ActiveRecord::Migration[5.2]
  def change
    create_table :articulateds do |t|
      t.references :amendment, foreign_key: true, null: false
      t.string :type, null: false
      t.references :section, foreign_key: true, null: false, index: true
      t.string :title, null: false
      t.text :text, null: false
      t.text :justification, null: false
      t.string :number

      t.timestamps
    end
  end
end
