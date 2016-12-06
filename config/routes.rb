Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root to: 'home#index'
  resources :users, only: [:index, :show, :edit, :update]
end
