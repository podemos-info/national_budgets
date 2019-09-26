# frozen_string_literal: true

class AmendmentsController < ApplicationController
  layout false, only: %i[browse_section browse_chapter]
  helper_method :budget, :amendment, :amendments,
                :section, :service, :program, :locked_section?,
                :chapter, :article, :concept, :subconcept

  # GET /amendments
  def index; end

  # GET /amendments/:id
  def show; end

  # GET /amendments/new
  def new
    @amendment = amendments.new
  end

  # GET /amendments/:id/edit
  def edit; end

  # POST /amendments
  def create
    @amendment = current_user.amendments.new(amendment_params)
    amendment.budget = budget

    if amendment.save
      redirect_to amendment_path(amendment), notice: 'Amendment was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /amendments/:id
  def update
    if amendment.update(amendment_params)
      redirect_to amendment_path(amendment), notice: 'Amendment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /amendments/:id
  def destroy
    amendment.destroy
    redirect_to amendments_url, notice: 'Amendment was successfully deleted.'
  end

  # GET /amendments/:id/browse/section(/:section_id(/:service_id(/:program_id)))
  def browse_section; end

  # GET /amendments/:id/browse/chapter(/:chapter_id(/:article_id(/:concept_id(/:subconcept_id))))
  def browse_chapter; end

  private

  def amendment_params
    params.require(:amendment).permit(:number, :type, :explanation, :user_id)
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
    @service ||= section.services.find(params[:service_id]) if params[:service_id]
  end

  def program
    @program ||= section.programs.find(params[:program_id]) if params[:program_id]
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
end
