# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    def self.allowed_modifications
      [
        Modifications::AdditionModification,
        Modifications::RemovalModification,
        Modifications::OrganismBudgetIncomeModification,
        Modifications::OrganismBudgetExpenditureModification
      ]
    end

    include HasModifications
    include HasModificationSection

    def completed?
      any_modifications? && balance.zero? && next_modification_type.empty?
    end

    def self.position
      2
    end
  end
end