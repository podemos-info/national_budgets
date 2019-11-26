# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    def self.allowed_modifications_str
      [
        'Modifications::AdditionModification',
        'Modifications::RemovalModification',
        'Modifications::OrganismBudgetIncomeModification',
        'Modifications::OrganismBudgetExpenditureModification'
      ]
    end

    include HasModifications
    include HasModificationSection

    def self.position
      2
    end
  end
end
