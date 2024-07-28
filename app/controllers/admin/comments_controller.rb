class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  # コメントの一覧表示
  def index
    @comments = Comment.includes(:user, :post).all
  end

  # コメントの削除
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントが削除されました。'
  end
end