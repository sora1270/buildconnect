class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :update_recruit_status]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :update_recruit_status]
  before_action :set_genres, only: [:new, :edit, :create, :update]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @user = @post.user
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.update_recruit_status
      redirect_to @post, notice: '投稿が成功しました。'
    else
      Rails.logger.debug "Post Errors: #{@post.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      @post.update_recruit_status
      redirect_to @post, notice: "投稿が更新されました。"
    else
      Rails.logger.debug "Post Errors: #{@post.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿が削除されました。"
  end

  def update_recruit_status
    if @post.update(post_params)
      @post.update_recruit_status
      redirect_to @post, notice: '募集人数が更新されました。'
    else
      Rails.logger.debug "Post Errors: #{@post.errors.full_messages.join(', ')}"
      render :edit, alert: '募集人数の更新に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_genres
    @genres = Genre.all
  end

  def post_params
    params.require(:post).permit(:title, :duration, :location, :contact_info, :requirements, :payment_schedule, :number_of_recruits, :application_deadline, :content, :current_recruits, genre_ids: [])
  end
end