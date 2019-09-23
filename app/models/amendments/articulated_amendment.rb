# frozen_string_literal: true

module Amendments
  class ArticulatedAmendment < Amendment
    has_one :articulated, foreign_key: 'amendment_id'

    def allow_articulateds?
      true
    end
  end
end
