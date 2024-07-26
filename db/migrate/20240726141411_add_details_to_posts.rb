class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :requirements, :string
    add_column :posts, :payment_schedule, :string
    add_column :posts, :number_of_recruits, :integer
    add_column :posts, :application_deadline, :date
  end
end
