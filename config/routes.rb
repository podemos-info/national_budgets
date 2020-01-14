# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  namespace :admin do
    # multiple belongs_to for activeadmin hack
    resources :programs
    resources :organisms do
      resources :programs
    end
    resources :sections do
      resources :programs
    end
  end

  authenticate :user do
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
end
