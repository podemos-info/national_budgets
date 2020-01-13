# frozen_string_literal: true

ActiveAdmin.register Service do
  belongs_to :section

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |service|
      link_to(service.title, [:admin, service.section, service])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title, &:title
      row :section
      row :budget do
        service.section.budget
      end
    end
  end
end
