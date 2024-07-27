class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    
    if user
      current_user.follow(user)
      flash[:notice] = "フォローしました"
    else
      flash[:alert] = "ユーザーが見つかりません"
    end

    redirect_to user_path(user)
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    
    if relationship
      user = relationship.followed
      current_user.unfollow(user)
      flash[:notice] = "フォローを解除しました"
    else
      flash[:alert] = "フォロー関係が見つかりません"
    end

    redirect_to user_path(user)
  end

  def followings
    @user = User.find(params[:user_id])
    
    if @user
      @users = @user.followings
    else
      flash[:alert] = "ユーザーが見つかりません"
      @users = []
    end
  end

  def followers
    @user = User.find(params[:user_id])
    
    if @user
      @users = @user.followers
    else
      flash[:alert] = "ユーザーが見つかりません"
      @users = []
    end
  end
end