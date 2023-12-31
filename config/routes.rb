Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  resources :posts do
    resources :comments, except: [:show, :index]
  end
  resources :categories, except: :show

  namespace :user do
    resources :posts, only: [:index]
    resources :comments, only: [:index]
  end
end
