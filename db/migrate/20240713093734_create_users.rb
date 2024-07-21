class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :last_name, null: false, default: "" # 名前(姓)
      t.string :first_name, null: false, default: "" # 名前(名)
      t.string :last_name_kana, null: false, default: "" # カナ(姓)
      t.string :first_name_kana, null: false, default: "" # カナ(名)
      t.string :phone_number, null: false, default: "" # 電話番号
      t.string :company_name, null: false, default: "" # 企業名
      t.string :industry, null: false, default: "" # 業種
      t.string :email, null: false, default: "" # メールアドレス
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
