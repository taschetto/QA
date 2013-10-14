QA::Application.routes.draw do
  get "admin/dashboard"
  devise_for :users
  resources :categories, only: [:show] do
    resources :questions, except: [:index] do
      resources :answers, except: [:index, :show ]
    end
  end
  resources :users, only: [:show]

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
