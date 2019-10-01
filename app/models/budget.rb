# frozen_string_literal: true

class Budget < ApplicationRecord
  has_many :amendments, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :services, through: :sections
  has_many :programs, through: :sections
  has_many :chapters, dependent: :destroy
  has_many :articles, through: :chapters
  has_many :concepts, through: :articles
  has_many :subconcepts, through: :concepts
end
