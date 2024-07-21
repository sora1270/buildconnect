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

# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  # プロフィール画像の取得メソッド
  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def full_name
    "#{last_name} #{first_name}".strip
  end
end

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end