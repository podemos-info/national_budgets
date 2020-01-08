# frozen_string_literal: true

module BrowseModificationChapter
  extend ActiveSupport::Concern

  included do
    helper_method :chapter, :article, :concepts, :concept, :subconcepts, :subconcept
  end

  def browse_chapter
    return if browse_action_handle

    render layout: false
  end

  private

  def chapter
    @chapter ||= budget.chapters.find(params[:chapter_id]) if params[:chapter_id]
  end

  def article
    @article ||= chapter.articles.find(params[:article_id]) if params[:article_id]
  end

  def concepts
    amendment.filter_collection_with_added(article.concepts, modification_type)
  end

  def concept
    @concept ||= article.concepts.find(params[:concept_id]) if params[:concept_id]
  end

  def subconcepts
    amendment.filter_collection_with_added(concept.subconcepts, modification_type)
  end

  def subconcept
    @subconcept ||= concept.subconcepts.find(params[:subconcept_id]) if params[:subconcept_id]
  end
end
