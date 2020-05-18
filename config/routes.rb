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

  namespace :admin do
    namespace :roles do
      get '/users', to: 'users#edit', as: 'users_edit'
    end
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
    resources :users,  only: [:update]
    resources :roles,  only: [:index, :create]
    resources :groups, only: [:index, :create]
    resources :cohorts, only: [:index, :show]
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :invitations, only: [:create]

        namespace :users do
          patch '/add_roles', to: 'roles#add'
          patch '/remove_roles', to: 'roles#remove'
        end
        resources :roles, only: [:update, :destroy]
      end

      namespace :users do
        get '/by_name', to: 'by_name#index'
        get '/by_cohort', to: 'by_cohort#index'
        get '/by_github', to: 'by_github#show'
        get '/search_all', to: 'search_all#index'
        get '/by_name', to: 'by_name#index'
      end

      resources :users, only: [:show, :index]
      resources :groups, only: [:update, :destroy]
      get '/cohorts', to: 'cohorts#index'
      get '/user_credentials', to: 'credentials#show'
    end
  end
end
