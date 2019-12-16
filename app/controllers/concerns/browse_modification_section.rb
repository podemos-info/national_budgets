# frozen_string_literal: true

module BrowseModificationSection
  extend ActiveSupport::Concern

  included do
    helper_method :locked_section?, :locked_organism?,
                  :sections, :section, :service, :organism, :program, :programs
  end

  def browse_section
    return if browse_action_handle

    render layout: false
  end

  private

  def section
    @section ||= budget.sections.find(params[:section_id]) if params[:section_id]
  end

  def sections
    amendment.class.filtered_sections(budget.sections)
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

  def programs
    @programs ||= amendment.class.filtered_programs(programs_parent.programs, modification_class)
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
end
