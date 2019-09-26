# frozen_string_literal: true

class Amendment < ApplicationRecord
  belongs_to :user
  belongs_to :budget
  validate :type_cannot_be_changed, on: :update, if: :locked_type?

  def modifications?
    false
  end

  def modifications?
    false
  end

  def allow_modifications?
    false
  end

  def articulated?
    false
  end

  def allow_articulated?
    false
  end

  def locked_type?
    persisted? && (articulated? || modifications?)
  end

  def type_cannot_be_changed
    errors.add(:type, 'can not be changed') if type_changed? && type != type_was
  end

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end
end
