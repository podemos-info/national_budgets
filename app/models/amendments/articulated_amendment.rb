# frozen_string_literal: true

module Amendments
  class ArticulatedAmendment < Amendment
    has_one :articulated, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
    delegate :section, to: :articulated, allow_nil: true

    def articulated?
      articulated.present?
    end

    def allow_articulated?
      true
    end

    def section
      @section ||= articulated.section if articulated?
    end
  end
end
