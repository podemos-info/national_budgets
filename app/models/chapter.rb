# frozen_string_literal: true

class Chapter < ApplicationRecord
  include HasFullTitle

  belongs_to :budget, optional: false
  has_many :articles, dependent: :destroy
  has_many :concepts, through: :articles
end
