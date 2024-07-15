class HomesController < ApplicationController
  def top
    @posts = Post.all # または必要なクエリを使って投稿データを取得する
  end

  def about
  end
end
