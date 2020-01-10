# frozen_string_literal: true

class Section < ApplicationRecord
  include HasFullTitle

  belongs_to :budget, optional: false
  has_many :services, dependent: :destroy
  has_many :programs, dependent: :destroy
  has_many :organisms, dependent: :destroy

  def name
    "#{budget.title} - #{title}"
  end
end
