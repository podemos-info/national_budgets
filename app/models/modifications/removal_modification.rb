# frozen_string_literal: true

module Modifications
  class RemovalModification < Modification
    validates :amount, presence: true

    def count_amount
      amount * -1
    end

    def self.position
      2
    end
  end
end
