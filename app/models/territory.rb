# frozen_string_literal: true

class Territory < ApplicationRecord
  include HasType
  has_many :amendments, dependent: :nullify

  def display_name
    "#{type_name}: #{name}"
  end
end
