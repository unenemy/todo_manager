TodoManager::Application.routes.draw do
  devise_for :users
  resources :tasks do
    post :share, :on => :member
    get :share_form, :on => :member
  end
  resources :showtasks
  root to: "showtasks#index"
end
