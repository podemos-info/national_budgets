# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  included do
    has_many :modifications, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
  end

  def allow_modifications?
    true
  end

  def any_modifications?
    modifications.size.positive?
  end

  def balance
    modifications.map(&:count_amount).sum
  end

  def compensation_type
    if balance.positive?
      'Modifications::RemovalModification'
    elsif balance.zero?
      nil
    else
      'Modifications::AdditionModification'
    end
  end

  def compensation_amount
    balance.abs
  end

  def completed?
    modifications.size > 1 && balance.zero?
  end

  def modifications_descendants
    modifications.map { |m| m.class.to_s }
  end

  def any_modification_descendant?(descendant_model)
    modifications_descendants.include?(descendant_model)
  end

  def locked_modification_descendant?(descendant_model)
    return false if descendant_model.index('Modifications::OrganismBudget').nil?

    any_modification_descendant?(descendant_model)
  end

  def excluded_modification_descendants
    %w[]
  end
end
