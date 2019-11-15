# frozen_string_literal: true

module Amendments
  class StandardAmendment < Amendment
    include HasModifications
    include HasModificationSection

    def excluded_modification_descendants
      %w[Modifications::OrganismBudgetIncomeModification Modifications::OrganismBudgetExpenditureModification]
    end

    def self.position
      1
    end
  end
end
