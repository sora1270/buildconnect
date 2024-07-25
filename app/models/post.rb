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
    case method
    when 'perfect'
      where('title = ?', content)
    when 'forward'
      where('title LIKE ?', "#{content}%")
    when 'backward'
      where('title LIKE ?', "%#{content}")
    when 'partial'
      where('title LIKE ?', "%#{content}%")
    else
      none # 無効な検索方法が指定された場合の処理
    end
  end
end