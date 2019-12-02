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
    include HasModificationOrganism

    def self.position
      2
    end

    def locked_organism?
      organism_budget_income_modifications.any? || organism_budget_expenditure_modifications.any?
    end
  end
end
