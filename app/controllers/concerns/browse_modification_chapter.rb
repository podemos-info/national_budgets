# frozen_string_literal: true

module BrowseModificationChapter
  extend ActiveSupport::Concern

  included do
    helper_method :chapter, :article, :concept, :subconcept
  end

  def browse_chapter
    render layout: false
  end

  private

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
end
