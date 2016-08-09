Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, constraints: { format: 'json' } do
    resources :workspaces, only: [:index], constraints: { format: 'json' }

    get 'tasks', to: 'tasks#index'
    get 'tasks/todo', to: 'tasks#todo'
    get 'tasks/unassigned', to: 'tasks#unassigned'
    get 'tasks/unplanned', to: 'tasks#unplanned'
  end
end
