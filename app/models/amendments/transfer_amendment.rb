# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    has_many :modifications, foreign_key: 'amendment_id', class_name: 'Modifications::TransferModification'

    def allow_modifications?
      true
    end
  end
end
