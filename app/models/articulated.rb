# frozen_string_literal: true

class Articulated < ApplicationRecord
  include HasType
  include HasSectionBudget
  belongs_to :amendment, optional: false
  belongs_to :section, optional: false
  validates :section, :title, :text, :justification, presence: true
end
