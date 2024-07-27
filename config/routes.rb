Rails.application.routes.draw do
  # Admin namespace
  devise_for :admins, controllers: { 
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :genres, only: [:index, :new, :create, :edit, :update, :show]
    resources :homes, only: [:top]
    resources :posts
    resources :users, only: [:index, :show, :destroy] # 管理者用のユーザー一覧
  end
  
  # Posts routes for general users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    member do
      patch :update_recruit_status
    end
  end

  # Companies routes
  resources :companies, only: [:new]

  # Devise for user authentication
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  # User routes
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
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

  # Genre routes for displaying users by genre
  resources :genres, only: [:index, :show] do
    member do
      get :users
    end
  end

  # Root path
  root 'homes#top'
end