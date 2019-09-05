class Section < ApplicationRecord
  belongs_to :budget
  has_many :service
  has_many :program
  has_many :organism
end
