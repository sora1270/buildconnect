class CreateJoinTablePostsGenres < ActiveRecord::Migration[6.1]
  def change
    create_join_table :posts, :genres do |t|
      # t.index [:post_id, :genre_id]
      # t.index [:genre_id, :post_id]
    end
  end
end
