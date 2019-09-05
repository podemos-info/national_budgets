class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :ref, null: false
      t.string :title, null: false
      t.references :chapter, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
