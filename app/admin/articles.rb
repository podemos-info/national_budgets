# frozen_string_literal: true

ActiveAdmin.register Article do
  belongs_to :chapter

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |article|
      link_to(article.title, [:admin, chapter.budget, chapter])
    end
    column model_name(:concepts) do |article|
      link_to(model_total(article.concepts), [:admin, article, :concepts])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title
      row :budget
      row :chapter
    end

    panel t('active_admin.details', model: model_name(:chapter, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: resource, collection_model: :concepts)
        end
      end
    end
  end
end
