class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.references :user, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
