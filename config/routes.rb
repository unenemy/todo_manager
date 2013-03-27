TodoManager::Application.routes.draw do
  devise_for :users
  resources :tasks
  resources :showtasks
  root to: "showtasks#index"
end
