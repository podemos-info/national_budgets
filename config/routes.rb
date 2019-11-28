# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :user do
    resources :budgets, shallow: true, path: '/' do
      resources :amendments do
        resources :articulateds, except: [:show], shallow: false
        resources :modifications, except: [:show], shallow: false
        member do
          get 'browse/section(/:section_id(/:service_id(/:program_id)))',
              to: 'amendments#browse_section', as: :browse_section
          get 'browse/organism/:section_id(/:organism_id)',
              to: 'amendments#browse_organism', as: :browse_organism
          get 'browse/program/:organism_id(/:program_id)',
              to: 'amendments#browse_program', as: :browse_program
          get 'browse/chapter(/:chapter_id(/:article_id(/:concept_id(/:subconcept_id))))',
              to: 'amendments#browse_chapter', as: :browse_chapter
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
