# frozen_string_literal: true

module ModelDescendantsHelper
  def descendants_collection(parent_model, excluded_descendants = nil)
    parent_model.descendants.sort_by(&:position).map { |a| [a.to_s, a.new.type_name] unless excluded_descendants&.include? a.to_s }.compact
  end
end
