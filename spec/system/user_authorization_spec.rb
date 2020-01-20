# frozen_string_literal: true

require 'rails_helper'

describe 'User authorization', type: :system, js: true do
  include_context 'with a CAS login'

  context 'when user is editor' do
    it 'can access to the frontend' do
      visit budgets_path
      expect(page).to have_content('Proyectos de presupuestos')
    end

    it 'can\'t access to the backend' do
      visit admin_root_path
      expect(page).not_to have_content('Welcome to ActiveAdmin.')
    end
  end

  context 'when user is super_admin' do
    let(:user_role) { :super_admin }

    before do
      current_user = User.last
      current_user.role = 'super_admin'
      current_user.save!
    end

    it 'can access to the frontend' do
      visit budgets_path
      expect(page).to have_content('Proyectos de presupuestos')
    end

    it 'can access to the backend' do
      visit admin_root_path
      expect(page).to have_content('Welcome to ActiveAdmin.')
    end
  end
end
