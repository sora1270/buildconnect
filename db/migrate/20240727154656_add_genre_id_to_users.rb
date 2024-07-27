class AddGenreIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :genre_id, :integer
    add_index :users, :genre_id
  end
end
