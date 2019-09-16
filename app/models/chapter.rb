class Chapter < ApplicationRecord
  belongs_to :budget
  has_many :articles
  has_many :concepts, through: :articles

  include HasFullTitle
end
