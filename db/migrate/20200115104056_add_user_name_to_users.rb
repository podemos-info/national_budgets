# frozen_string_literal: true

class AddUserNameToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :user_name, :string
    ActiveRecord::Base.connection.execute("UPDATE users SET user_name = CONCAT('user_', id)")
    change_column_null :users, :user_name, false
    add_index :users, :user_name, unique: true
  end

  def down
    remove_column :users, :user_name
  end
end
