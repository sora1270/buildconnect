class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :show, :followings, :followers, :edit]
  before_action :set_user, only: [:show, :followings, :followers]

  def mypage
    @users = User.all
  end

  def followings
    @title = "フォロー中"
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers
    render 'show_follow'
  end

  def edit
  end

  def index
  end

  def show
    @posts = @user.posts.order(created_at: :desc)  # ユーザーが投稿した一覧を取得
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end