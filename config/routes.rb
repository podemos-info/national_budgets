# frozen_string_literal: true

require 'sidekiq/web'
Sidekiq::Web.set :sessions, false

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  authenticate :user, ->(u) { u.super_admin? } do
    mount Sidekiq::Web, at: '/sidekiq', as: :sidekiq
  end

  ActiveAdmin.routes(self)

  namespace :admin do
    # HACK: multiple belongs_to for activeadmin
    resources :programs
    resources :organisms do
      resources :programs
    end
    resources :sections do
      resources :programs
    end
  end

  resources :budgets, shallow: true, path: '/' do
    resources :amendments do
      resources :articulateds, except: [:show], shallow: false
      resources :modifications, except: [:show], shallow: false
      member do
        get 'browse/section/:modification_type(/:section_id(/:service_or_organism_id(/:program_id)))',
            to: 'amendments#browse_section', as: :browse_section
        get 'browse/chapter/:modification_type(/:chapter_id(/:article_id(/:concept_id(/:subconcept_id))))',
            to: 'amendments#browse_chapter', as: :browse_chapter
      end
    end
  end
end
