Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:index, :show, :edit] do
      get 'mypage', on: :collection
    end
    resources :genres, only: [:index, :edit]
    resources :homes, only: [:top]
    resources :posts, only: [:index, :destroy]
  end

  resources :companies, only: [:new]
  
  resources :posts, only: [:new, :index, :show, :edit]

  resources :users, only: [:edit, :show] do
    member do
      get :followings
      get :followers
    end
    get 'mypage', on: :collection
    resources :relationships, only: [:create, :destroy]
  end

  get 'homes/about'
  
  devise_for :users

  root 'homes#top'
end