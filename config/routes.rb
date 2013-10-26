QA::Application.routes.draw do
  get "admin/dashboard"
  devise_for :users
  resources :categories, only: [:show] do
    resources :questions, except: [:index] do
      get 'fix'
      resources :answers, except: [:index, :show ] do
        get 'like'
        get 'unlike'
      end
    end
  end
  resources :users, only: [:show]

  root :to => "home#index"

  namespace :admin do
    resources :users, except: [:new, :create, :show]
    resources :categories do
      member do
        get 'addchild'
        post 'addchild'
      end
    end
  end
end
