# frozen_string_literal: true

class Amendment < ApplicationRecord
  belongs_to :user
  belongs_to :budget
  validate :type_can_not_change, on: :update

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

  def type_can_not_change
    errors.add(:type, 'can not be changed') if type_changed? && locked_type?
  end

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end
end
