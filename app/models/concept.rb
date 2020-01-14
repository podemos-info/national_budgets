# frozen_string_literal: true

class Concept < ApplicationRecord
  include HasFullTitle

  belongs_to :article, optional: false
  has_many :subconcepts, dependent: :destroy
  delegate :budget, to: :article, allow_nil: false
end
