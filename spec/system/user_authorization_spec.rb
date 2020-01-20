# frozen_string_literal: true

require 'rails_helper'

def cas_login
  fill_in 'username', with: 'john.doe@email.com'
  fill_in 'password', with: 'any password'
  click_button 'Login'
end

describe 'User authorization', type: :system, js: true do
  it 'visits the frontend as editor' do
    visit budgets_path
    cas_login
    expect(page).to have_content('Proyectos de presupuestos')
  end

  it 'tries to visit the backend as editor' do
    visit admin_root_path
    cas_login
    expect(page).not_to have_content('Welcome to ActiveAdmin.')
  end

  it 'turns current user into super_admin and visits the backend' do
    visit admin_root_path
    cas_login
    expect(page).not_to have_content('Welcome to ActiveAdmin.')

    current_user = User.last
    current_user.role = 'super_admin'
    current_user.save!

    visit admin_root_path
    expect(page).to have_content('Welcome to ActiveAdmin.')
  end
end
