class Budget < ApplicationRecord
  has_many :amendments
  has_many :sections
  has_many :services, through: :sections
  has_many :programs, through: :sections
  has_many :chapters
  has_many :articles, through: :chapters
  has_many :concepts, through: :articles
  has_many :subconcepts, through: :concepts
end
