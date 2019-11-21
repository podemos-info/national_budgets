# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  included do
    has_many :modifications, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
    allowed_modifications.each do |klass|
      has_many klass.name.demodulize.pluralize.underscore.to_sym,
               class_name: klass.name, # rubocop:disable Rails/ReflectionClassName
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

  def pending_modifications
    allowed_modifications - modifications.map(&:class)
  end

  def pending_modifications_sentence
    pending_modifications.map { |klass| "«#{klass.type_name.downcase}»" }.to_sentence
  end

  def any_modifications?
    modifications.size.positive?
  end

  def balance
    modifications.map(&:balance_amount).sum
  end

  def total_amount
    modifications.map(&:total_amount).sum
  end

  def display_amount
    modifications.map(&:display_amount).sum
  end

  def next_modification_type
    allowed_modifications.select { |klass| klass if klass.next_modification_type_for?(self) }
  end

  def disabled_modifications_types
    allowed_modifications.select { |klass| klass if klass.disabled_modification_type_for?(self) }
  end

  def status_icon_params
    if pending_modifications.size.positive?
      ['square-o', class: 'status', title: I18n.t('helpers.action.pending_modifications', modifications: pending_modifications_sentence)]
    elsif display_amount.negative?
      ['minus-square-o', class: 'status', title: I18n.t('helpers.action.negative_balance')]
    elsif display_amount.positive?
      ['plus-square-o', class: 'status', title: I18n.t('helpers.action.positive_balance')]
    elsif completed?
      ['check-square-o', class: 'status text-success', title: I18n.t('helpers.action.completed')]
    end
  end
end
