Rails.application.routes.draw do
  authenticate :user do
    resources :amendments
    resources :amendments do
      resources :articulateds, controller: 'articulateds'
    end
  end
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
