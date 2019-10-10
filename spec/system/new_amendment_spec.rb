# frozen_string_literal: true

require 'rails_helper'

describe 'Amendment creation', type: :system do
  let(:user) { create(:user) }
  let(:budget) { create(:budget) }

  before do
    login_as user
  end

  it 'creates a new amendment' do
    visit budget_amendments_path(budget)

    first(:link, 'Crear enmienda').click

    choose 'Alta/baja'

    fill_in 'Exposición de motivos', with: 'Porque sí'
    fill_in 'Nº de enmienda', with: '123456'

    click_button 'Crear enmienda'

    expect(page).to have_content('Porque sí')
    expect(page).to have_current_path(amendment_path(Amendment.last))
  end
end
