# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Posts' do
          ul do
            Budget.all.map do |budget|
              li link_to(budget.title, admin_budget_path(budget))
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to ActiveAdmin.'
        end
      end
    end
  end
end
