# frozen_string_literal: true

module Amendments
  class ArticulatedAmendment < Amendment
    has_one :articulated, foreign_key: 'amendment_id'
    delegate :section, to: :articulated, allow_nil: true

    def articulated?
      !articulated.nil?
    end

    def allow_articulated?
      true
    end
  end
end
