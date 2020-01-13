# frozen_string_literal: true

ActiveAdmin.register Chapter do
  belongs_to :budget

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |chapter|
      link_to(chapter.title, [:admin, budget, chapter])
    end
    column model_name(:articles) do |chapter|
      link_to(model_total(chapter.articles), [:admin, chapter, :articles])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title, &:title
      row :budget
    end

    panel t('active_admin.details', model: model_name(:section, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: chapter, collection_model: :articles)
        end
      end
    end
  end
end
