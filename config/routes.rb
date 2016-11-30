Rails.application.routes.draw do
  resource 'confirmations', only: [:new, :create]
end
