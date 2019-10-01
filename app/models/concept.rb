# frozen_string_literal: true

class Concept < ApplicationRecord
  include HasFullTitle

  belongs_to :article
  has_many :subconcepts, dependent: :destroy
end
