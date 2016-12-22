Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: 'users/registrations'
  }

  root to: 'home#index'

  resources :users,         only: [:index, :show, :edit, :update]
  resources :affiliations,  only: [:new, :create]
  resources :invitations,   only: [:new, :create, :update, :destroy, :index]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]

      get '/user', to: 'credentials#show'
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
  end

end
