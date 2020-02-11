# frozen_string_literal: true

module HasType
  extend ActiveSupport::Concern

  included do
    validates :type, presence: true
    validate :type_locked, on: :update, if: :locked_type?
  end

  def type_name(attributes = {})
    self.class.type_name(attributes)
  end

  def position
    self.class.position
  end

  def locked_type?
    false
  end

  def type_locked
    errors.add(:type, I18n.t('activerecord.errors.type_locked')) if type_changed? && type != type_was
  end

  class_methods do
    def type_name(attributes = {})
      human_attribute_name(:type, attributes)
    end
  end
end
