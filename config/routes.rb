Rails.application.routes.draw do

  resource :home, only: 'show'

  root to: 'home#show'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  resources :building_profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
