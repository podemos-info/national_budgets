# frozen_string_literal: true

ActiveAdmin.register Concept do
  belongs_to :article

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |concept|
      link_to(concept.title, [:admin, concept.article, concept])
    end
    column model_name(:subconcepts) do |concept|
      link_to(model_total(concept.subconcepts), [:admin, concept, :subconcepts])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title
      row :article
      row :chapter do
        concept.article.chapter
      end
      row :budget
    end

    panel t('active_admin.details', model: model_name(:concept, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: concept, collection_model: :subconcepts)
        end
      end
    end
  end
end
