# frozen_string_literal: true

module Amendments
  class ArticulatedAmendment < Amendment
    has_one :articulated, foreign_key: 'amendment_id'
    delegate :section, to: :articulated, allow_nil: true

    def allow_articulateds?
      true
    end
  end
end
