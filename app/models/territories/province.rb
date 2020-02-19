# frozen_string_literal: true

module Territories
  class Province < Territory
    belongs_to :community,
               class_name: 'Territories::Community',
               foreign_key: :parent_id,
               inverse_of: :provinces
    delegate :country, to: :community, allow_nil: true
  end
end
