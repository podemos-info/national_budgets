# frozen_string_literal: true

module HasAmount
  extend ActiveSupport::Concern
  included do
    include ActionView::Helpers::NumberHelper
  end

  def currency_amount
    number_to_currency amount, precision: 2, unit: ''
  end
end
