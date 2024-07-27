class HomesController < ApplicationController
  def top
    @current_user = current_user
    @posts = Post.order(created_at: :desc).limit(4)
  end

  def about
  end
  
  def set_genres
    @genres = Genre.all
  end
  
end
