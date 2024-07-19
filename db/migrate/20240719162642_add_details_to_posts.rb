class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :industry, :string
    add_column :posts, :duration, :string
    add_column :posts, :budget, :string
    add_column :posts, :location, :string
  end
end
