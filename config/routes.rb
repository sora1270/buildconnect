Rails.application.routes.draw do
  # Admin namespace
  namespace :admin do
    resources :genres, only: [:index, :edit]
    resources :homes, only: [:top]
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  # Posts routes for general users
  resources :posts, except: [:destroy] # except を使ってdestroyを除外

  # Companies routes
  resources :companies, only: [:new]

  # Devise for user authentication
  devise_for :users

  # User routes
  resources :users, only: [:show, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
    end
    collection do
      get :mypage
    end
  end

  # Relationships routes
  resources :relationships, only: [:create, :destroy] do
    collection do
      delete ':user_id', to: 'relationships#destroy', as: :destroy_for_user
      post ':user_id', to: 'relationships#create', as: :create_for_user
    end
  end

  # Static pages and search
  get 'homes/about'
  get 'search', to: 'search#index'

  # Root path
  root 'homes#top'
end