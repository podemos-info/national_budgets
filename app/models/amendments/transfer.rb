# frozen_string_literal: true

module Amendments
  class Transfer < Amendment
    def self.allowed_modifications_str
      [
        'Modifications::Addition',
        'Modifications::Removal',
        'Modifications::OrganismBudgetIncome',
        'Modifications::OrganismBudgetExpenditure'
      ]
    end

    include HasModifications
    include HasModificationSection
    include HasModificationOrganism

    def self.position
      2
    end

    def locked_organism?
      organism_budget_incomes.any? || organism_budget_expenditures.any?
    end
  end
end
