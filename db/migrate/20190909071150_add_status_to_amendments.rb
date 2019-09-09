class AddStatusToAmendments < ActiveRecord::Migration[5.2]
  def change
    add_column :amendments, :status, :integer, null: false
  end
end
