# frozen_string_literal: true

class Organism < ApplicationRecord
  include HasFullTitle
  belongs_to :section, optional: false
  has_many :programs, dependent: :destroy
end
