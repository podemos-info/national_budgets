# frozen_string_literal: true

class AmendmentsDocument < ApplicationRecord
  belongs_to :budget, optional: false
  belongs_to :section, optional: true
  has_one_attached :document
  enum role: { 'docx' => 0, 'xlsx' => 1 }
end
