Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :workspaces, only: [:index]
  resources :tasks, only: [:index]
end
