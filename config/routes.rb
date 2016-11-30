Rails.application.routes.draw do
  get   'initialize',   to: 'initialize#new'
  post  'initialize',   to: 'initialize#create'
end
