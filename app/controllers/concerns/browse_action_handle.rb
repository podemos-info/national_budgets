# frozen_string_literal: true

module BrowseActionHandle
  extend ActiveSupport::Concern

  included do
    helper_method :object_original_fullpath
  end

  private

  def browse_action_handle
    return unless object_params

    if object
      update_object
    elsif object_found
      redirect_to browse_redirect_path(object_found),
                  info: flash_message(:object_found_warning, :info, model: object_found.model_name.human.downcase)
    else
      create_object
    end
  end

  def action
    params[:action].to_sym
  end

  def current_model
    params[:object][:model].to_sym
  end

  def object
    @object ||= send(current_model)
  end

  def object_found
    @object_found ||= added_objects_collection.find_by(object_params)
  end

  def object_params
    params.require(:object).permit(:title).merge(added: true) if params[:object]
  end

  def create_object
    object = added_objects_collection.new(object_params)
    object.save
    redirect_to(browse_redirect_path(object), success: flash_message(:create_object_success, :check, model: object.model_name.human))
  end

  def update_object
    object.update(object_params)
    redirect_to(browse_redirect_path(object), success: flash_message(:update_object_success, :check, model: object.model_name.human))
  end

  def added_objects_collection
    case current_model
    when :program
      programs_parent.programs
    when :concept
      article.concepts
    when :subconcept
      concept.subconcepts
    end
  end

  def browse_redirect_path(object = false)
    send "#{action}_amendment_path", browse_redirect_params(object)
  end

  def browse_redirect_params(object = false)
    redirect_params = { browse_section: browse_section_redirect_params,
                        browse_chapter: browse_chapter_redirect_params }[action]

    object ||= added_objects_collection.where(object_params).first
    redirect_params.merge!("#{current_model}_id": object)
  end

  def browse_section_redirect_params
    { modification_type: modification_type,
      section_id: section,
      service_or_organism_id: programs_previous,
      program_id: program,
      locked_section: locked_section?,
      locked_program: locked_program?,
      locked_organism: locked_organism? }
  end

  def browse_chapter_redirect_params
    { modification_type: modification_type,
      chapter_id: chapter,
      article_id: article,
      concept_id: concept,
      subconcept_id: subconcept }
  end

  def object_original_fullpath
    request.original_fullpath.split('&object[').first
  end
end
