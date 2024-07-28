class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
  end

  def users_mypage
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'ユーザーが削除されました。'
  end

  def followings
    @title = "フォロー中"
    @users = @user.followings
    render 'show_follow'
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

  def mypage
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :company_name, :industry, :email, :phone_number, :password, :password_confirmation)
  end
end