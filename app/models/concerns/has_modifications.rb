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
    modifications.sum(:amount)
  end

  def compensation_amount
    balance * -1
  end

  def completed?
    modifications.size > 1 && balance.zero?
  end
end
