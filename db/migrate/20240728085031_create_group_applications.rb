class GroupApplication < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :status, presence: true
end