# frozen_string_literal: true

class Program < ApplicationRecord
  include HasFullTitle

  belongs_to :section, optional: true
  belongs_to :organism, optional: true

  def parent
    section || organism
  end

  def budget
    section&.budget || organism&.section&.budget
  end
end
