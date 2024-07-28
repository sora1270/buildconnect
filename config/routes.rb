Rails.application.routes.draw do
  namespace :admin do
    get 'groups/index'
    get 'groups/show'
    get 'groups/new'
    get 'groups/create'
    get 'groups/edit'
    get 'groups/update'
    get 'groups/destroy'
  end
  # Admin namespace
  devise_for :admins, controllers: { 
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :genres, only: [:index, :new, :create, :edit, :update, :show]
    resources :homes, only: [:top]
    resources :posts
    resources :users, only: [:index, :show, :destroy] # 管理者用のユーザー一覧
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
  end

  # Posts routes for general users
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :groups, only: [:create, :show, :update, :destroy] do
      member do
        get :members
        post :join
      end
      resources :join_requests, only: [:index, :create, :update, :destroy] do
        member do
          post :approve
          post :reject
          post :re_request
        end
      end
    end
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