# frozen_string_literal: true

class Articulated < ApplicationRecord
  include HasType
  include HasAmendmentBudget
  belongs_to :amendment
  belongs_to :section
  validates :type, :title, :text, :justification, presence: true
end
