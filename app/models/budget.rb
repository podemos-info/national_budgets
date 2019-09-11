class Budget < ApplicationRecord
  has_many :amendments
  has_many :sections
  has_many :services, through: :sections
end
