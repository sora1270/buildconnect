class AddContactInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact_info, :string
  end
end
