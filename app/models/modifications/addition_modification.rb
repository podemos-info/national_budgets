# frozen_string_literal: true

module Modifications
  class AdditionModification < Modification
    validates :amount, presence: true

    def self.position
      1
    end

    def self.next_modification_type_for?(amendment)
      amendment.addition_modifications.size.zero? || amendment.balance.negative?
    end

    def self.modification_detail?
      true
    end

    def self.present_fields
      %i[section service program chapter project project_new amount]
    end
  end
end
