# frozen_string_literal: true

module HasModifications
  extend ActiveSupport::Concern

  included do
    has_many :modifications, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
    allowed_modifications_str.each do |class_name|
      has_many class_name.demodulize.pluralize.underscore.to_sym,
               class_name: class_name, # rubocop:disable Rails/ReflectionClassName
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

  def completed?
    !next_modification_type
  end

  def pending_modifications
    allowed_modifications - persisted_modifications.map(&:class)
  end

  def pending_modifications_sentence
    pending_modifications.map { |klass| "«#{klass.type_name.downcase}»" }.to_sentence
  end

  def persisted_modifications
    modifications.select(&:persisted?)
  end

  def any_modifications?
    modifications.size.positive?
  end

  def balance
    persisted_modifications.sum(&:balance_amount)
  end

  def total_amount
    persisted_modifications.sum(&:total_amount)
  end

  def display_amount
    persisted_modifications.sum(&:display_amount)
  end

  def next_modification_type
    allowed_modifications.select { |m| m if m.next_modification_type_for?(self) }.first
  end

  def disabled_modifications_types
    allowed_modifications.select { |klass| klass if klass.disabled_modification_type_for?(self) }
  end

  def status_icon_params
    if pending_modifications.any?
      ['square-o', class: 'status', title: I18n.t('helpers.action.pending_modifications', modifications: pending_modifications_sentence)]
    elsif display_amount.negative?
      ['minus-square-o', class: 'status', title: I18n.t('helpers.action.negative_balance')]
    elsif display_amount.positive?
      ['plus-square-o', class: 'status', title: I18n.t('helpers.action.positive_balance')]
    elsif completed?
      ['check-square-o', class: 'status text-success', title: I18n.t('helpers.action.completed')]
    end
  end

  def allowed_new_field_for?(modification_type, field)
    self.class.allowed_new_field_for?(modification_type, field)
  end

  def filter_collection_with_added(collection, modification_type)
    self.class.filter_collection_with_added(collection, modification_type)
  end

  class_methods do
    def allowed_modifications
      allowed_modifications_str.map(&:constantize)
    end

    def filter_collection_with_added(collection, modification_type)
      return collection if allowed_new_field_for?(modification_type, collection.model_name.name.underscore.to_sym)

      collection.where(added: false)
    end

    def allowed_new_field_for?(modification_type, field)
      modifications_allowed_new_fields[modification_type].include?(field)
    end
  end
end
