# frozen_string_literal: true

class Organism < ApplicationRecord
  belongs_to :section, optional: false
end
