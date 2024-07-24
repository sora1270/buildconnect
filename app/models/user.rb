class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  has_many :posts, dependent: :destroy

  has_one_attached :profile_image

  validates :last_name, :first_name, presence: true
  validates :phone_number, presence: true, allow_blank: true
  
  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      # デフォルト画像を返す場合、Rails の asset pipeline を利用してパスを指定する
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
  
  def full_name_kana
    "#{last_name_kana} #{first_name_kana}".strip
  end
  
  def self.search_for(content, method)
    content ||= ''  # contentがnilの場合は空文字列を代入

    if method == 'perfect'
      User.where('full_name = ? OR email = ?', content, content)
    elsif method == 'forward'
      User.where('full_name LIKE ? OR email LIKE ?', "#{content}%", "#{content}%")
    elsif method == 'backward'
      User.where('full_name LIKE ? OR email LIKE ?', "%#{content}", "%#{content}")
    else
      User.where('full_name LIKE ? OR email LIKE ?', "%#{content}%", "%#{content}%")
    end
  end
end