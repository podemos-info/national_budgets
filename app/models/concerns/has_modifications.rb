# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  included do
    has_many :modifications, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
    allowed_modifications.each do |klass|
      has_many klass.name.demodulize.pluralize.underscore.to_sym,
               class_name: klass.name,
               foreign_key: :amendment_id,
               dependent: :destroy,
               inverse_of: :amendment
    end
  end

  def allow_modifications?
    true
  end

  def allowed_modifications
    self.class.allowed_modifications
  end

  def any_modifications?
    modifications.size.positive?
  end

  def balance
    modifications.map(&:balance_amount).sum
  end

  def total_amount
    addition_modifications.map(&:total_amount).sum
  end

  def next_modification_type
    allowed_modifications.select { |klass| klass if klass.next_modification_type_for?(self) }
  end

  def disabled_modifications_types
    allowed_modifications.select { |klass| klass if klass.disabled_modification_type_for?(self) }
  end

  def status_icon_params
    if completed?
      ['check-square-o', class: 'pl-2 text-success', title: I18n.t('helpers.action.completed')]
    elsif balance.negative?
      ['minus-square-o', class: 'pl-2', title: I18n.t('helpers.action.incomplete_negative_balance')]
    elsif balance.positive?
      ['plus-square-o', class: 'pl-2', title: I18n.t('helpers.action.incomplete_positive_balance')]
    else
      ['square-o', class: 'pl-2', title: I18n.t('helpers.action.incomplete_empty')]
    end
  end
end
