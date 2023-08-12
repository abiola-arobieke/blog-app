Rails.application.routes.draw do
  devise_for :users
  get 'comments/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create] 
      resources :likes, only: [:create]
    end
  end

  resources :users, only: [] do
    member do
      get 'api_token'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :new, :create] do
          resources :comments, only: [:index, :new, :create]
          resources :likes, only: [:create]
        end
      end
    end
  end
end
