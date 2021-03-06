Rails.application.routes.draw do

  resource :home, only: 'show'

  root to: 'home#show'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      invitations: 'users/invitations'
  }

  resources :frequently_asked_questions
  resources :building_profiles
  resource :profile, only: [:edit, :update]
  resource :account, only: [:show, :create] do
    post :change
    post :withdraw
    post :refund
  end
  resources :support_requests, only: [:show, :index, :create, :new]
  resources :support_replies, only: [:create]
  resources :documents

  namespace :borrower do
    resource :dashboard, only: [:show]
    resources :requests, only: [:new, :create, :show, :index, :destroy]
  end

  namespace :investor do
    resource :dashboard, only: [:show]
    resources :requests, only: [:new, :create, :show, :index, :destroy]
  end

  namespace :admin do
    resource :dashboard, only: [:show] do
      post :ban
    end
    resources :user_info, only: [:show]
    resource :time_travels, only: [:new, :create]
    resources :stats, only: [:index]
    resources :borrowers_stats, only: [:index, :show]
    resources :investors_stats, only: [:index, :show]
  end

  namespace :underwriter do
    resource :dashboard, only: [:show]
    resources :borrower_requests, only: [:show, :update]
    resources :refills, only: [:index] do
      collection do
        get :borrowers
        get :investors
      end
      member do
        post :borrower_refill
        post :investor_refill
      end
    end
    resources :documents
  end

  namespace :support do
    resource :dashboard, only: [:show]
    resources :support_requests
    resources :support_replies, only: [:create]
  end

  get '*unmatched_route', to: 'application#not_found' # should be last

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
