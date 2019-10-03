# frozen_string_literal: true

class Chapter < ApplicationRecord
  include HasFullTitle

  belongs_to :budget
  has_many :articles, dependent: :destroy
  has_many :concepts, through: :articles
end
