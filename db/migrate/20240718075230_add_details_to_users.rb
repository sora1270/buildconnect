class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :company_name, :string
    # add_column :users, :industry, :string # 既に存在するカラムはコメントアウトまたは削除
    add_column :users, :phone_number, :string
  end
end