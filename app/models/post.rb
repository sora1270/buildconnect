class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :industry, presence: true
  validates :duration, presence: true
  validates :location, presence: true
  validates :contact_info, presence: true
  validates :requirements, presence: true
  validates :payment_schedule, presence: true
  validates :number_of_recruits, presence: true
  validates :application_deadline, presence: true
  validates :content, presence: true
  validates :current_recruits, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  # 現在の募集人数
  def current_recruits
    # 現在の募集人数を返すロジックをここに追加
    # 例えば、コメントの数や別の関連モデルから取得する
    # ここでは仮に0を返す
    0
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
      self.update(status: '募集終了')
    else
      self.update(status: "#{current_recruits}/#{number_of_recruits}")
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
      none # 無効な検索方法が指定された場合の処理
    end
  end
end