# frozen_string_literal: true

module ModelDescendantsHelper
  def descendants_collection(parent_model)
    parent_model.descendants.map { |a| [a.to_s, a.new.type_name] }
  end
end
