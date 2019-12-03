# frozen_string_literal: true

class AmendmentsController < ApplicationController
  include ModelsHelper
  include HasFlashMessages
  layout false, only: %i[browse_section browse_chapter browse_organism browse_program]
  helper_method :budget, :amendment, :amendments, :modification_type,
                :section, :service, :program, :organism, :locked_section?, :locked_organism?,
                :chapter, :article, :concept, :subconcept

  def index; end

  def show; end

  def new
    @amendment = amendments.new
  end

  def edit; end

  def create
    @amendment = current_user.amendments.new(amendment_params)
    amendment.budget = budget

    if amendment.save
      redirect_to after_create_path, success: flash_message(:success, :check)
    else
      render action: 'new'
    end
  end

  def update
    if amendment.update(amendment_params)
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'edit'
    end
  end

  def destroy
    amendment.destroy
    redirect_to budget_amendments_path(budget), danger: flash_message(:success, :trash)
  end

  def browse_section; end

  def browse_chapter; end

  private

  def after_create_path
    if amendment.allow_articulated?
      new_amendment_articulated_path(amendment)
    else
      new_amendment_modification_path(amendment)
    end
  end

  def amendment_params
    @permited_params = %i[number explanation user_id]
    @permited_params << :type unless amendment&.locked_type?

    params.require(:amendment).permit(*@permited_params)
  end

  def budget
    @budget ||= amendment&.budget || Budget.find(params[:budget_id])
  end

  def amendment
    @amendment ||= params[:id] && Amendment.find(params[:id])
  end

  def amendments
    @amendments ||= budget.amendments
  end

  def section
    @section ||= budget.sections.find(params[:section_id]) if params[:section_id]
  end

  def service
    return unless modification_type.use_field?(:service) && params[:service_or_organism_id]

    @service ||= section.services.find(params[:service_or_organism_id])
  end

  def organism
    return unless modification_type.use_field?(:organism) && params[:service_or_organism_id]

    @organism ||= section.organisms.find(params[:service_or_organism_id])
  end

  def program
    @program ||= (modification_type.use_field?(:organism) ? organism : section)&.programs&.find(params[:program_id]) if params[:program_id]
  end

  def chapter
    @chapter ||= budget.chapters.find(params[:chapter_id]) if params[:chapter_id]
  end

  def article
    @article ||= chapter.articles.find(params[:article_id]) if params[:article_id]
  end

  def concept
    @concept ||= article.concepts.find(params[:concept_id]) if params[:concept_id]
  end

  def subconcept
    @subconcept ||= concept.subconcepts.find(params[:subconcept_id]) if params[:subconcept_id]
  end

  def locked_section?
    params['locked_section'] == 'true'
  end

  def locked_organism?
    params['locked_organism'] == 'true'
  end

  def modification_type
    params[:modification_type].constantize
  end
end
