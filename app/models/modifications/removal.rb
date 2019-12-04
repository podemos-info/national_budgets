# frozen_string_literal: true

module Modifications
  class Removal < Modification
    validates :amount, presence: true

    def balance_amount
      -amount
    end

    alias display_amount balance_amount

    def total_amount
      0
    end

    def self.position
      2
    end

    def self.next_modification_type_for?(amendment)
      amendment.removals.none? || amendment.balance.positive?
    end

    def self.present_fields
      %i[section service program chapter project amount]
    end
  end
end
