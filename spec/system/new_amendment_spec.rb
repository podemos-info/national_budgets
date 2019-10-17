# frozen_string_literal: true

require 'rails_helper'

describe 'Amendment creation', type: :system, js: true do
  let(:user) { create(:user) }
  let(:budget) { create(:budget) }
  let(:section) { create(:section, :with_childs, budget: budget) }
  let(:chapter) { create(:chapter, :with_childs, budget: budget) }
  let(:article) { create(:article, :with_concepts, chapter: chapter) }
  let(:concept) { create(:concept, :with_subconcepts, article: article) }
  let(:subconcept) { create(:subconcept, concept: concept) }

  before do
    section
    subconcept
    login_as user
  end

  it 'creates a new standard amendment' do
    visit budget_amendments_path(budget)

    first(:link, 'Crear enmienda').click

    find(:label, text: 'Alta/baja').click

    fill_in 'Exposición de motivos', with: 'Porque sí'
    fill_in 'Nº de enmienda', with: '123456'

    click_button 'Crear enmienda'

    expect(page).to have_content('La enmienda ha sido creada.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))

    click_link section.full_title
    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link chapter.full_title
    click_link article.full_title
    click_link concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '1234'
    find(:label, text: 'Proyecto nuevo').click
    fill_in 'Importe', with: '1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))

    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '4321'
    fill_in 'Importe', with: '-1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}")
    expect(page).to have_current_path(amendment_path(Amendment.last))
  end
end
