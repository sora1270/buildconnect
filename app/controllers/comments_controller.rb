class CommentsController < ApplicationController
before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'コメントを追加しました。'
    else
      redirect_to @post, alert: 'コメントを追加できませんでした。'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post, notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
