# frozen_string_literal: true

module HasPseudoiframeBrowsing
  extend ActiveSupport::Concern

  included do
    layout false, only: %i[browse_section browse_chapter]
    helper_method :modification_type, :modification_class, :locked_section?, :locked_organism?
    delegate :programs, to: :programs_parent
  end

  def browse_section; end

  def browse_chapter; end

  def section
    @section ||= budget.sections.find(params[:section_id]) if params[:section_id]
  end

  def service
    return unless modification_class.use_field?(:service) && params[:service_or_organism_id]

    @service ||= section.services.find(params[:service_or_organism_id])
  end

  def organism
    return unless modification_class.use_field?(:organism) && params[:service_or_organism_id]

    @organism ||= section.organisms.find(params[:service_or_organism_id])
  end

  def programs_parent
    if modification_class.use_field?(:organism)
      organism
    else
      section
    end
  end

  def program
    @program ||= programs_parent&.programs&.find(params[:program_id]) if params[:program_id]
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
    params[:modification_type]
  end

  def modification_class
    modification_class = "Modifications::#{modification_type.camelcase}".constantize if modification_type
    modification_class if amendment.class.allowed_modifications.include?(modification_class)
  end
end
