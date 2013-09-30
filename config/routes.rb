QA::Application.routes.draw do
  get "admin/dashboard"
  devise_for :users
  resources :categories, only: [:show]

  root :to => "home#index"

  namespace :admin do
    resources :categories do
      member do
        get 'addchild'
        post 'addchild'
      end
    end
  end
end
