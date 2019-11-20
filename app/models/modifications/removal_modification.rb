# frozen_string_literal: true

module Modifications
  class RemovalModification < Modification
    validates :amount, presence: true

    def balance_amount
      -amount
    end

    def total_amount
      0
    end

    def self.position
      2
    end

    def self.next_modification_type_for?(amendment)
      amendment.removal_modifications.size.zero? || amendment.balance.positive?
    end

    def self.modification_detail?
      true
    end
  end
end
