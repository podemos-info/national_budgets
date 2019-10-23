# frozen_string_literal: true

class Amendment < ApplicationRecord
  include HasType
  belongs_to :user
  belongs_to :budget
  validates :type, :number, :explanation, presence: true
  validate :type_cannot_be_changed, on: :update, if: :locked_type?

  def any_modifications?; end

  def allow_modifications?; end

  def any_articulated?; end

  def allow_articulated?; end

  def completed?; end

  def locked_type?
    persisted? && (any_articulated? || any_modifications?)
  end

  def type_cannot_be_changed
    errors.add(:type, 'can not be changed') if type_changed? && type != type_was
  end

  def section; end

  def any_section?
    section.present?
  end
end
