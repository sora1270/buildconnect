class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :industry, presence: true
  validates :duration, presence: true
  validates :location, presence: true
  validates :contact_info, presence: true
end