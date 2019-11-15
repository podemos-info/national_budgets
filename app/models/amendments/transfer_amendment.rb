# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    include HasModifications
    include HasModificationSection

    def self.position
      2
    end
  end
end
