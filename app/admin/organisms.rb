# frozen_string_literal: true

ActiveAdmin.register Organism do
  belongs_to :section

  index do
    selectable_column
    column :ref, &:visible_ref
    column :title do |organism|
      link_to(organism.title, [:admin, organism.section, organism])
    end
    column model_name(:programs) do |organism|
      link_to(model_total(organism.programs), [:admin, organism, :programs])
    end
    actions
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title, &:title
      row :section
    end

    panel t('active_admin.details', model: model_name(:section, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: organism, collection_model: :programs)
        end
      end
    end
  end
end
