# frozen_string_literal: true

class Section < ApplicationRecord
  include HasFullTitle

  belongs_to :budget
  has_many :services, dependent: :destroy
  has_many :programs, dependent: :destroy
  has_many :organisms, dependent: :destroy
end
