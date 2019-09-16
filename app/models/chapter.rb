class Chapter < ApplicationRecord
  include HasFullTitle

  belongs_to :budget
  has_many :articles
  has_many :concepts, through: :articles
end
