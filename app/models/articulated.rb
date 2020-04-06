# frozen_string_literal: true

class Articulated < ApplicationRecord
  include HasAmendmentNumber
  include HasSectionBudget
  include HasType
  after_save :set_amendment_number, if: :number_criterias_changed?
  belongs_to :amendment, optional: false, inverse_of: :articulated, class_name: 'Amendments::Articulated'
  belongs_to :section, optional: false
  validates :section, :title, :text, :justification, presence: true

  NUMBER_REBUILD_FIELDS = %w[section_id].freeze

  def articulated_number?
    self.class.articulated_number?
  end

  def self.articulated_number?
    false
  end

  def number_criterias_changed?
    (saved_changes.keys & self.class::NUMBER_REBUILD_FIELDS).any?
  end

  def set_amendment_number
    amendment.numeber
  end
end
