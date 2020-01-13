# frozen_string_literal: true

ActiveAdmin.register Section do
  belongs_to :budget

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |section|
      link_to(section.title, [:admin, section.budget, section])
    end
    column model_name(:services) do |section|
      link_to(model_total(section.services), [:admin, section, :services])
    end
    column model_name(:organisms) do |section|
      link_to(model_total(section.organisms), [:admin, section, :organisms])
    end
    column model_name(:programs) do |section|
      link_to(model_total(section.programs), [:admin, section, :programs])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title
      row :budget do
        section.budget ? link_to(section.budget.title, [:admin, section.budget]) : false
      end
    end

    panel t('active_admin.details', model: model_name(:section, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: resource, collection_model: :services)
        end
        column do
          collection_panel(context: self, resource: resource, collection_model: :organisms)
        end
        column do
          collection_panel(context: self, resource: resource, collection_model: :programs)
        end
      end
    end
  end
end
