# frozen_string_literal: true

class AddAdded < ActiveRecord::Migration[6.0]
  def tables
    %i[programs concepts subconcepts]
  end

  def table_model(table)
    table.to_s.singularize.camelcase.constantize
  end

  def up
    tables.each do |table|
      change_column table, :ref, :string, null: true
      add_column table, :added, :boolean, default: false
      table_model(table).where(ref: '').each { |object| object.update(ref: nil) }
    end
  end

  def down
    tables.each do |table|
      table_model(table).where(ref: nil).each { |object| object.update(ref: '') }
      change_column table, :ref, :string, null: false
      remove_column table, :added
    end
  end
end
