# frozen_string_literal: true

require 'rails_helper'

def cas_login
  fill_in 'username', with: 'john.doe@email.com'
  fill_in 'password', with: 'any password'
  click_button 'Login'
end

describe 'User authorization', type: :system, js: true do
  before do
    visit budgets_path
    fill_in 'username', with: 'john.doe@email.com'
    fill_in 'password', with: 'any password'
    click_button 'Login'
  end

  context 'when user is editor' do
    it 'can access the frontend' do
      visit budgets_path
      expect(page).to have_content('Proyectos de presupuestos')
    end

    it 'can\'t access the backend' do
      visit admin_root_path
      expect(page).not_to have_content('Welcome to ActiveAdmin.')
    end
  end

  context 'when user is super_admin' do
    before do
      current_user = User.last
      current_user.role = 'super_admin'
      current_user.save!
    end

    it 'can access the frontend' do
      visit budgets_path
      expect(page).to have_content('Proyectos de presupuestos')
    end

    it 'can access the backend' do
      visit admin_root_path
      expect(page).to have_content('Welcome to ActiveAdmin.')
    end
  end
end
