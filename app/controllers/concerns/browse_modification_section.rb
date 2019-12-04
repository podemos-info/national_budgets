# frozen_string_literal: true

module BrowseModificationSection
  extend ActiveSupport::Concern

  included do
    helper_method :modification_type, :modification_class, :locked_section?, :locked_organism?,
                  :section, :service, :program, :programs, :organism
    delegate :programs, to: :programs_parent
  end

  def browse_section
    render layout: false
  end

  private

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
