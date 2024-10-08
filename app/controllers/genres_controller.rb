class GenresController < ApplicationController
  before_action :set_genre, only: [:show]

  def show
    @users = User.where(industry: @genre.name)
  end

  def index
    @genres = Genre.all
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end
end