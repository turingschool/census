Rails.application.routes.draw do
  resource 'users', only: [:new, :create, :update, :edit, :show]
end
