# frozen_string_literal: true

module HasModificationOrganism
  extend ActiveSupport::Concern

  included do
    delegate :organism, to: :first_organism_budget_income, allow_nil: true
  end

  def allow_organism_budget?
    true
  end

  def first_organism_budget_income
    organism_budget_incomes.first
  end

  def locked_organism?(modification)
    organism_budget_incomes.where.not(id: modification.id).any? || organism_budget_expenditures.where.not(id: modification.id).any?
  end
end
