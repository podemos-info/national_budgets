# frozen_string_literal: true

module HasType
  extend ActiveSupport::Concern

  included do
    validates :type, presence: true
  end

  def type_name
    self.class.human_attribute_name(:type)
  end
end
