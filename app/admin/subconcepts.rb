# frozen_string_literal: true

ActiveAdmin.register Subconcept do
  belongs_to :concept

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |subconcept|
      link_to(subconcept.title, [:admin, subconcept.concept, subconcept])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title
      row :concept
      row :article do
        concept.article
      end
      row :chapter do
        concept.article.chapter
      end
      row :budget
    end
  end
end
