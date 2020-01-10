# frozen_string_literal: true

ActiveAdmin.register Budget do
  config.sort_order = 'date_desc'

  permit_params :title, :user_id, :date

  index do
    selectable_column
    column :title do |budget|
      link_to(budget.title, [:admin, budget])
    end
    column :date
    actions defaults: true do |budget|
      link_to("Ver secciones", [:admin, budget, :sections])
    end
  end

  show do
    attributes_table do
      row :user
      row :title
      row :date
    end
 
    panel "Secciones" do
      ul do
        budget.sections.each do |section|
          li link_to(section.title, [:admin, budget, section])
        end
      end
    end
  end

  filter :title
  filter :date

  csv do
    column :title
    column :date
  end

  form do |f|
    f.inputs do
      f.input :user, as: :string, input_html: { readonly: true }
      f.input :title
      f.input :date
    end

    f.actions
  end

  action_item :cosas, only: :show do
    link_to "Hacer cosas", cosas_admin_budget_path(budget)
  end

  action_item :mas_cosas do
    link_to "Hacer más cosas", mas_cosas_admin_budgets_path
  end

  collection_action :mas_cosas do
    flash[:notice] = "Hice más cosas!"
    redirect_back(fallback_location: admin_root_path)
  end

  member_action :cosas do
    flash[:notice] = "Hice cosas con #{resource.title}"
    redirect_back(fallback_location: admin_root_path)
  end

  controller do
    def build_resource
      super.tap {|ret| ret.user = current_user unless ret.persisted?}
    end
  end
end
