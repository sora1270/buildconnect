class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :show, :followings, :followers, :edit]
  before_action :set_user, only: [:show, :followings, :followers, :following_list, :follower_list]

  def mypage
    @users = User.all
  end

  def followings
    @title = "フォロー中"
    @users = @user.followings
    render 'relationships/followings'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers
    render 'relationships/followers'
  end

  def following_list
    @title = "フォロー中"
    @users = @user.followings
  end

  def follower_list
    @title = "フォロワー"
    @users = @user.followers
  end

  def edit
  end

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.order(created_at: :desc)  # ユーザーが投稿した一覧を取得
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end