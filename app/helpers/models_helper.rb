# frozen_string_literal: true

module ModelsHelper
  def descendants_collection(parent_model)
    classes_collection(parent_model.descendants)
  end

  def classes_collection(classes)
    classes.sort_by(&:position).map { |a| [a.to_s, a.type_name] }
  end
end
