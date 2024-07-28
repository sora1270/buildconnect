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
  
  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id'
  has_many :group_memberships
  has_many :joined_groups, through: :group_memberships, source: :group
  has_many :groups, through: :join_requests
  has_many :join_requests

  has_one_attached :profile_image

  validates :last_name, :first_name, presence: true
  validates :phone_number, presence: true, allow_blank: true
  validates :industry, presence: true

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
  
  def name
    full_name
  end

  def self.search_for(content, search_method)
    if content.present?
      content = convert_katakana_to_hiragana(content)
    end

    case search_method
    when 'partial'
      where('last_name LIKE :content OR first_name LIKE :content OR last_name_kana LIKE :content OR first_name_kana LIKE :content', content: "%#{content}%")
    else
      all
    end
  end

  private

  def self.convert_katakana_to_hiragana(text)
    text.tr("ァィゥェォカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン", "ぁぃぅぇぉかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん")
  end
end