class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :content, presence: true
  validates :industry, presence: true
  validates :duration, presence: true
  validates :location, presence: true
  validates :contact_info, presence: true  # 追加
end
