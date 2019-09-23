Rails.application.routes.draw do
  authenticate :user do
    resources :amendments do
      resources :articulateds, :except => [:show]
      resources :modifications, :except => [:show]
      member do
        get 'browse/section(/:section_id(/:service_id(/:program_id)))', to: "amendments#browse_section", as: :browse_section
        get 'browse/chapter(/:chapter_id(/:article_id(/:concept_id(/:subconcept_id))))', to: "amendments#browse_chapter", as: :browse_chapter
      end
    end
  end
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
