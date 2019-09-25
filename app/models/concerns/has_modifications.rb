# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  def modifications?
    modifications.size.positive?
  end

  def allow_modifications?
    true
  end
end
