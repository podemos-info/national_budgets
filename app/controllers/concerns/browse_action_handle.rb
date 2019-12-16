# frozen_string_literal: true

module BrowseActionHandle
  extend ActiveSupport::Concern

  def browse_action_handle
    return unless browse_object_params

    @object = create_browse_object || update_browse_object
    redirect_to browse_redirect_path(@object)
    true
  end

  def create_browse_object
    return unless params[:new] && !params[:edit]

    browse_redirect_if_object_exists && return

    @object = browse_objects_collection.new(browse_object_params)
    return unless @object.save

    @object
  end

  def update_browse_object
    return unless params[:edit] && params[:object_id]

    @object = browse_objects_collection.find(params[:object_id])
    return unless @object.update(browse_object_params)

    @object
  end

  def browse_redirect_if_object_exists
    return if browse_objects_collection.where(browse_object_params).empty?

    redirect_to browse_redirect_path
  end

  def browse_redirect_path(object = false)
    path_method = params[:action] == 'browse_section' ? 'browse_section_amendment_path' : 'browse_chapter_amendment_path'
    send path_method, browse_redirect_params(object)
  end

  def browse_objects_collection
    case params[:model]
    when 'program'
      programs_parent.programs
    when 'concept'
      article.concepts
    when 'subconcept'
      concept.subconcepts
    end
  end

  def browse_redirect_params(object = false)
    @redirect_params = { browse_section: browse_section_redirect_params,
                         browse_chapter: browse_chapter_redirect_params }[params[:action].to_sym]

    object ||= browse_objects_collection.where(browse_object_params).first object

    @redirect_params.merge!("#{params[:model]}_id": object)
  end

  def browse_section_redirect_params
    { modification_type: modification_type,
      section_id: section,
      service_or_organism_id: service || organism,
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

  private

  def browse_object_params
    @browse_object_params ||= { title: params[:new] || params[:edit], added: true } if params[:new] || (params[:edit] && params[:object_id])
  end
end
