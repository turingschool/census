Rails.application.routes.draw do
  root to: 'home#index'
  
  resource 'users', only: [:new, :create, :update, :edit, :show]
end
