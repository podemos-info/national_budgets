# frozen_string_literal: true

class Articulated < ApplicationRecord
  include HasType
  include HasSectionBudget
  belongs_to :amendment, optional: false
  belongs_to :section, optional: false
  validates :section, :title, :text, :justification, presence: true

  def articulated_number?
    self.class.articulated_number?
  end

  def self.articulated_number?
    false
  end
end
