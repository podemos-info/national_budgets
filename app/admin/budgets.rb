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
    column model_name(:sections) do |budget|
      link_to(model_total(budget.sections), [:admin, budget, :sections])
    end
    column model_name(:chapters) do |budget|
      link_to(model_total(budget.chapters), [:admin, budget, :chapters])
    end
    column model_name(:amendments) do |budget|
      link_to(model_total(budget.amendments), [:admin, budget, :amendments])
    end
    column t('helpers.label.amendment.total_amount')
    actions
  end

  show do
    attributes_table do
      row :user
      row :title
      row :date
      row model_name(:amendments) do
        link_to(model_total(budget.amendments), [:admin, budget, :amendments])
      end
    end

    panel t('active_admin.details', model: model_name(:budget, 1).downcase) do
      columns do
        column do
          collection_panel(context: self, resource: resource, collection_model: :sections)
        end
        column do
          collection_panel(context: self, resource: resource, collection_model: :chapters)
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
    link_to 'Hacer cosas', cosas_admin_budget_path(budget)
  end

  action_item :mas_cosas do
    link_to 'Hacer más cosas', mas_cosas_admin_budgets_path
  end

  collection_action :mas_cosas do
    flash[:notice] = 'Hice más cosas!'
    redirect_back(fallback_location: admin_root_path)
  end

  member_action :cosas do
    flash[:notice] = "Hice cosas con #{resource.title}"
    redirect_back(fallback_location: admin_root_path)
  end

  controller do
    def build_resource
      super.tap { |ret| ret.user = current_user unless ret.persisted? }
    end
  end
end
