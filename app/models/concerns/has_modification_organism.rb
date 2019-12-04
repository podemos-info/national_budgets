# frozen_string_literal: true

module HasModificationOrganism
  extend ActiveSupport::Concern

  included do
    delegate :organism, to: :first_organism_budget_income, allow_nil: true
  end

  def first_organism_budget_income
    organism_budget_incomes.first
  end
end
