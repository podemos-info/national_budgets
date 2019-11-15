# frozen_string_literal: true

module Modifications
  class AdditionModification < Modification
    validates :amount, presence: true

    def count_amount
      amount
    end

    def self.position
      1
    end
  end
end
