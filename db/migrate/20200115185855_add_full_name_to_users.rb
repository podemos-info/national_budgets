# frozen_string_literal: true

class AddFullNameToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :full_name, :string
    ActiveRecord::Base.connection.execute('UPDATE users SET full_name = email')
    change_column_null :users, :full_name, false
  end

  def down
    remove_column :users, :full_name
  end
end
