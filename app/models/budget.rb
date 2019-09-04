class Budget < ApplicationRecord
  has_many :section
  has_many :service, through: :section
end
