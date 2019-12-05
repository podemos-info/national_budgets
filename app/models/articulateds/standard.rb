# frozen_string_literal: true

module Articulateds
  class Standard < Articulated
    def self.position
      1
    end

    def self.articulated_number?
      true
    end
  end
end
