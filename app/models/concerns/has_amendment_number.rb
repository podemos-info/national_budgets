# frozen_string_literal: true

module HasAmendmentNumber
  extend ActiveSupport::Concern

  included do
    after_save :set_amendment_number
  end

  private

  def set_amendment_number
    amendment.set_number
  end
end
