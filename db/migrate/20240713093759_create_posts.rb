class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :industry    # 追加
      t.string :duration    # 追加
      t.string :budget      # 追加
      t.string :location    # 追加
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end