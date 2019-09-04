class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.integer :ref
      t.string :title
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
