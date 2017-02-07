Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

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
      namespace :users do
        get '/by_name', to: 'by_name#index'

        get '/search_all', to: 'search_all#index'
      end

      get '/users/:id', to: 'users#show', as: 'user'

      get '/users', to: 'users#index'

      get '/user_credentials', to: 'credentials#show'

      post '/sendgrid/events', to: 'send_grid/events#update'

      patch '/roles/:id',   to: 'roles#update'
      delete '/roles/:id',  to: 'roles#destroy'
      patch '/groups/:id',  to: 'groups#update'
      delete '/groups/:id', to: 'groups#destroy'
      namespace :users do
        get '/by_name', to: 'by_name#index'
      end
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
    resources :users,  only: [:update]
    resources :roles,  only: [:index, :create]
    resources :groups, only: [:index, :create]
    resources :cohorts
  end

end
