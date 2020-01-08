# frozen_string_literal: true

module BrowseActionHandle
  extend ActiveSupport::Concern

  def browse_action_handle
    return unless object_params

    if object
      object.update(object_params)
      redirect_to browse_redirect_path(object), success: flash_message(:success, :check)
    else
      object = added_objects_collection.new(object_params)
      object.save
      redirect_to browse_redirect_path(object), success: flash_message(:success, :check)
    end
  end

  private

  def action
    params[:action].to_sym
  end

  def current_model
    params[:object][:model]
  end

  def object
    send(current_model) || added_objects_collection.find_by(object_params)
  end

  def object_params
    params.require(:object).permit(:title).merge(added: true) if params[:object]
  end

  def added_objects_collection
    case current_model
    when 'program'
      programs_parent.programs
    when 'concept'
      article.concepts
    when 'subconcept'
      concept.subconcepts
    end
  end

  def browse_redirect_path(object = false)
    send "#{action}_amendment_path", browse_redirect_params(object)
  end

  def browse_redirect_params(object = false)
    redirect_params = { browse_section: browse_section_redirect_params,
                        browse_chapter: browse_chapter_redirect_params }[action]

    object ||= added_objects_collection.where(object_params).first object
    redirect_params.merge!("#{current_model}_id": object)
  end

  def browse_section_redirect_params
    { modification_type: modification_type,
      section_id: section,
      service_or_organism_id: programs_previous,
      program_id: program,
      locked_section: locked_section?,
      locked_organism: locked_organism? }
  end

  def browse_chapter_redirect_params
    { modification_type: modification_type,
      chapter_id: chapter,
      article_id: article,
      concept_id: concept,
      subconcept_id: subconcept }
  end
end
