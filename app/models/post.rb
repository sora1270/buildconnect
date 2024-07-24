class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :industry, presence: true
  validates :duration, presence: true
  validates :location, presence: true
  validates :contact_info, presence: true
  
  def self.search_for(content, method)
    content ||= ''  # contentがnilの場合は空文字列を代入
    
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', "#{content}%")
    elsif method == 'backward'
      Post.where('title LIKE ?', "%#{content}")
    else
      Post.where('title LIKE ?', "%#{content}%")
    end
  end
end