class SearchController < ApplicationController
  def index
    @model = params[:model]
    @content = params[:content].presence || ''
    @method = params[:method].presence || 'forward'  # デフォルトの検索方法を指定

    case @model
    when 'user'
      @records = User.search_for(@content, @method)
    when 'post'
      @records = Post.search_for(@content, @method)
    else
      @records = []  # モデルが無効な場合は空の配列を返す
    end
  end
end
