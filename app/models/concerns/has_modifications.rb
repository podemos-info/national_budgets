# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  def allow_modifications?
    true
  end

  def any_modifications?
    modifications.size.positive?
  end

  def balance
    modifications.sum(:amount)
  end

  def completed?
    modifications.size > 1 && balance.zero?
  end
end
