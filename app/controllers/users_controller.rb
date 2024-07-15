class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :show]
  
  def mypage
    @users = User.all
  end
  
  def followings
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)  # ユーザーが投稿した一覧を取得
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end
end