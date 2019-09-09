class CreateModifications < ActiveRecord::Migration[5.2]
  def change
    create_table :modifications do |t|
      t.references :amendment, foreign_key: true
      t.string :type
      t.references :section, foreign_key: true
      t.references :service, foreign_key: true
      t.references :program, foreign_key: true
      t.references :chapter, foreign_key: true
      t.references :article, foreign_key: true
      t.references :concept, foreign_key: true
      t.references :subconcept, foreign_key: true
      t.string :project
      t.boolean :project_new
      t.decimal :amount, precision: 12, scale: 2

      t.timestamps
    end
  end
end
