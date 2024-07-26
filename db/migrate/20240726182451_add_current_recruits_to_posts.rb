class AddCurrentRecruitsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :current_recruits, :integer
  end
end
