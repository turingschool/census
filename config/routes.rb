Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resource 'users', only: [:new, :create, :update, :edit, :show]
end
