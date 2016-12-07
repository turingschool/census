Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root to: 'home#index'
  resources :users, only: [:index, :show, :edit, :update]
  resources :affiliations, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      get '/me', to: 'credentials#show'
    end
  end

end
