class Group < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :applications, class_name: 'GroupApplication', foreign_key: 'group_id', dependent: :destroy
  has_many :join_requests, dependent: :destroy
  has_many :members, through: :join_requests, source: :user
  has_many :group_memberships, dependent: :destroy
  
  validates :name, presence: true
  
  def join_requested_by?(user)
    join_requests.exists?(user: user)
  end
  
  def join_canceled_by?(user)
    join_requests.exists?(user: user, status: "canceled")
  end
  
end