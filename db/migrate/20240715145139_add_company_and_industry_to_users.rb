class AddCompanyAndIndustryToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company, :string
  end
end
