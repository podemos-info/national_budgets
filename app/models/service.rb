# frozen_string_literal: true

class Service < ApplicationRecord
  include HasFullTitle

  belongs_to :section
end
