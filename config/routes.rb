Rails.application.routes.draw do
  namespace :admin do
    resources :genres, only: [:index, :edit]
    resources :homes, only: [:top]
    resources :posts, only: [:index, :destroy]
  end

  resources :companies, only: [:new]

  resources :posts, only: [:new, :index, :show, :edit]

  devise_for :users

  resources :users, only: [:mypage, :show, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
    end
    collection do
      get :mypage
    end
  end

  resources :relationships, only: [:create, :destroy]

  get 'homes/about'

  root 'homes#top'
end