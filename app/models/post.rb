class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :genres
  has_many :comments, dependent: :destroy
  has_many :groups, dependent: :destroy

  # バリデーションの追加
  validates :title, :duration, :location, :contact_info, :requirements, :payment_schedule, :number_of_recruits, :application_deadline, :content, presence: true
  validates :current_recruits, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # 現在の募集人数を取得するメソッド
  def current_recruits
    read_attribute(:current_recruits) || 0
  end

  # 残りの日数を計算するメソッド
  def days_remaining
    return nil unless application_deadline.present?
    (application_deadline - Date.today).to_i
  end

  # 募集人数のステータスを表示するメソッド
  def recruit_status
    if number_of_recruits.nil?
      "情報なし"
    elsif recruits_filled?
      "募集終了"
    else
      "#{current_recruits}/#{number_of_recruits}"
    end
  end

  # 現在の募集人数を管理するメソッド
  def recruits_filled?
    current_recruits >= number_of_recruits
  end

  # ステータスを「募集終了」に更新するメソッド
  def update_recruit_status
    if recruits_filled?
      update(status: '募集終了')
    else
      update(status: "#{current_recruits}/#{number_of_recruits}")
    end
  end

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
      none
    end
  end
end