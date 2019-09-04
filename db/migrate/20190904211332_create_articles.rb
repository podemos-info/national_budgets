class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :ref
      t.string :title
      t.references :chapter, foreign_key: true

      t.timestamps
    end
  end
end
