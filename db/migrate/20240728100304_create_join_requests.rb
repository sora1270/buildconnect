class CreateJoinRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :join_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
