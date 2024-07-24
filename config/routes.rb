Rails.application.routes.draw do
  # Admin namespace
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  namespace :admin do
    resources :genres, only: [:index, :edit]
    resources :homes, only: [:top]
    resources :posts
    resources :users, only: [:index, :show, :destroy]# 管理者用のユーザー一覧
  end

  # Posts routes for general users
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create, :destroy]
  end

  # Companies routes
  resources :companies, only: [:new]

  # Devise for user authentication
  devise_for :users

  # User routes
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
      # These routes are needed for the links
      get :following_list
      get :follower_list
    end
    collection do
      get :mypage
    end
  end

  # Relationships routes
  resources :relationships, only: [:create, :destroy]

  # Static pages and search
  get 'homes/about'
  get 'search', to: 'search#index'

  # Root path
  root 'homes#top'
end