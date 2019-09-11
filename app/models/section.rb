class Section < ApplicationRecord
  belongs_to :budget
  has_many :services
  has_many :programs
  has_many :organisms
end
