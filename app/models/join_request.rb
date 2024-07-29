class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, uniqueness: { scope: :group_id }

  validates :status, presence: true

  before_create :set_default_status

  private

  def set_default_status
    self.status ||= :pending
  end

end
