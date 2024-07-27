class ChangeIndustryToStringInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :industry, :string
  end

  def down
    change_column :users, :industry, :integer
  end
end