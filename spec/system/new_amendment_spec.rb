# frozen_string_literal: true

require 'rails_helper'

describe 'Amendment creation', type: :system, js: true do
  let(:user) { create(:user) }
  let(:budget) { create(:budget, user: user) }
  let(:section) { create(:section, :with_children, budget: budget) }
  let(:organism) { create(:organism, :with_programs, section: section) }
  let(:chapter) { create(:chapter, :with_children, budget: budget) }
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

    fill_in 'Nº de enmienda', with: '123456'
    fill_in 'Exposición de motivos', with: 'Porque sí'

    click_button 'Crear enmienda'

    expect(page).to have_content('La enmienda ha sido creada.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to eq('Incompleta: falta «alta» y «baja»')

    click_link section.full_title
    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '1234'
    find(:label, text: 'Proyecto nuevo').click
    fill_in 'Importe', with: '1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to eq('Incompleta: falta «baja»')

    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '4321'
    fill_in 'Importe', with: '500000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-plus-square-o')['title']).to eq('Incompleta: balance positivo')

    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '4321'
    fill_in 'Importe', with: '1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-minus-square-o')['title']).to eq('Incompleta: balance negativo')

    click_link section.services.first.full_title
    click_link section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '4321'
    fill_in 'Importe', with: '500000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}")
    expect(page).to have_current_path(amendment_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-check-square-o')['title']).to eq('Completa')
  end

  it 'creates a new transfer amendment' do
    visit budget_amendments_path(budget)

    first(:link, 'Crear enmienda').click

    find(:label, text: 'Enmienda de transferencia').click

    fill_in 'Nº de enmienda', with: '123456'
    fill_in 'Exposición de motivos', with: 'Porque sí'

    click_button 'Crear enmienda'

    expect(page).to have_content('La enmienda ha sido creada.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title'])
      .to eq('Incompleta: falta «alta», «baja», «alta presupuesto de ingreso» y «alta presupuesto de gasto»')

    click_link organism.section.full_title
    click_link organism.section.services.first.full_title
    click_link organism.section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '1234'
    find(:label, text: 'Proyecto nuevo').click
    fill_in 'Importe', with: '1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title'])
      .to eq('Incompleta: falta «baja», «alta presupuesto de ingreso» y «alta presupuesto de gasto»')

    click_link organism.section.services.first.full_title
    click_link organism.section.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    fill_in 'Proyecto', with: '4321'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to eq('Incompleta: falta «alta presupuesto de ingreso» y «alta presupuesto de gasto»')

    click_link organism.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to eq('Incompleta: falta «alta presupuesto de gasto»')

    click_link organism.programs.first.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}")
    expect(page).to have_current_path(amendment_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-check-square-o')['title']).to eq('Completa')
  end

  it 'creates a new articulated amendment' do
    visit budget_amendments_path(budget)

    first(:link, 'Crear enmienda').click

    find(:label, text: 'Enmienda al articulado').click

    fill_in 'Nº de enmienda', with: '123456'
    fill_in 'Exposición de motivos', with: 'Porque sí'

    click_button 'Crear enmienda'

    expect(page).to have_content('La enmienda ha sido creada.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Completar articulado")
    expect(page).to have_current_path(new_amendment_articulated_path(Amendment.last))
    find(:css, 'i.fa.fa-square-o')['title'].should have_content 'Incompleta: falta «articulado»'

    find(:label, text: 'Articulado').click
    select section.full_title, from: 'Section'
    fill_in 'Título', with: 'Título para el articulado'
    fill_in 'Texto', with: 'Texto un poco más largo para el articulado...'
    fill_in 'Justificación', with: 'Justificación para el articulado...'
    fill_in 'Número', with: '123456'

    click_button 'Completar articulado'

    expect(page).to have_current_path(amendment_path(Amendment.last))
    find(:css, 'i.fa.fa-check-square-o')['title'].should have_content 'Completa'
  end
end
