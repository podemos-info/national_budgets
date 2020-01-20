# frozen_string_literal: true

require 'rails_helper'

describe 'Amendment creation', type: :system, js: true do
  include_context 'with a CAS login'

  let(:user) { create(:user) }
  let(:budget) { create(:budget, user: user) }
  let(:section) { create(:section, :with_children, budget: budget) }
  let(:section_without_organism) { create(:section, :with_children, budget: budget) }
  let(:organism) { create(:organism, :with_programs, section: section) }
  let(:chapter) { create(:chapter, :with_children, budget: budget) }
  let(:program_000x) { create(:program, ref: '000X', section: section) }
  let(:article) { create(:article, :with_concepts, chapter: chapter) }
  let(:concept) { create(:concept, :with_subconcepts, article: article) }
  let(:subconcept) { create(:subconcept, concept: concept) }

  before do
    section
    section_without_organism
    organism
    program_000x
    subconcept
    visit budget_amendments_path(budget)
  end

  it 'creates a new standard amendment' do
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
    click_link section.services.sample.full_title

    fill_in :object_title, with: "Título de programa nuevo\n"
    expect(page).to have_content('Programa creado.')
    expect(page).to have_content('Título de programa nuevo')
    find(:css, '.program.edit_link').click
    fill_in :object_title, with: "Título de programa nuevo modificado\n"
    expect(page).to have_content('Programa actualizado.')
    expect(page).to have_content('Título de programa nuevo modificado')
    find(:css, '.reset_link.program').click
    fill_in :object_title, with: "Título de programa nuevo modificado\n"
    expect(page).to have_content('Se ha encontrado un programa existente con el título introducido.')
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    fill_in :object_title, with: "Título de concepto nuevo\n"
    expect(page).to have_content('Concepto creado.')
    expect(page).to have_content('Título de concepto nuevo')
    fill_in :object_title, with: "Título de subconcepto nuevo\n"
    expect(page).to have_content('Subconcepto creado.')
    expect(page).to have_content('Título de subconcepto nuevo')

    fill_in 'Proyecto', with: '1234'
    find(:label, text: 'Proyecto nuevo').click
    fill_in 'Importe', with: '1000000'

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Añadir modificación")
    expect(page).to have_current_path(new_amendment_modification_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to eq('Incompleta: falta «baja»')

    click_link section.services.sample.full_title
    click_link section.programs.where(added: false).sample.full_title
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

    click_link section.services.sample.full_title
    click_link section.programs.where(added: false).sample.full_title
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

    click_link section.services.sample.full_title
    click_link section.programs.where(added: false).sample.full_title
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

    expect(page).not_to have_content(section_without_organism.full_title)
    click_link organism.section.full_title
    click_link organism.section.services.sample.full_title
    expect(page).not_to have_content(organism.programs.where.not(ref: '000X').sample.full_title)
    click_link program_000x.full_title
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

    click_link section.services.sample.full_title
    expect(page).not_to have_content(program_000x.full_title)
    click_link section.programs.where.not(ref: '000X').sample.full_title
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

    click_link organism.programs.sample.full_title
    click_link subconcept.concept.article.chapter.full_title
    click_link subconcept.concept.article.full_title
    click_link subconcept.concept.full_title
    click_link subconcept.full_title

    click_button 'Añadir modificación'

    expect(page).to have_content('La modificación ha sido añadida.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}")
    expect(page).to have_current_path(amendment_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-check-square-o')['title']).to eq('Completa')

    click_link 'Listado de enmiendas'
  end

  it 'creates a new articulated amendment' do
    first(:link, 'Crear enmienda').click

    find(:label, text: 'Enmienda al articulado').click

    fill_in 'Nº de enmienda', with: '123456'
    fill_in 'Exposición de motivos', with: 'Porque sí'

    click_button 'Crear enmienda'

    expect(page).to have_content('La enmienda ha sido creada.')
    expect(page).to have_content("#{Amendment.last.budget.title}: Enmienda n.º #{Amendment.last.number}: Completar articulado")
    expect(page).to have_current_path(new_amendment_articulated_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-square-o')['title']).to have_content('Incompleta: falta «articulado»')

    find(:label, text: 'Articulado').click
    select section.full_title, from: 'Section'
    fill_in 'Título', with: 'Título para el articulado'
    fill_in 'Texto', with: 'Texto un poco más largo para el articulado...'
    fill_in 'Justificación', with: 'Justificación para el articulado...'
    fill_in 'Número', with: '123456'

    click_button 'Completar articulado'

    expect(page).to have_current_path(amendment_path(Amendment.last))
    expect(find(:css, 'i.fa.fa-check-square-o')['title']).to have_content('Completa')
  end
end
