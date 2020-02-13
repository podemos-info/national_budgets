# frozen_string_literal: true

module Territories
  class Province < Territory
    belongs_to :comunity,
               class_name: 'Territories::Comunity',
               foreign_key: :parent_id,
               inverse_of: :provinces
    delegate :country, to: :comunity, allow_nil: true
  end
end
