class Block < ApplicationRecord
  belongs_to :blocker, class_name: "User"
  belongs_to :blocked, class_name: "User"

  with_options presence: true do
    validates :blocker_id
    validates :blocked_id
  end

  validates :blocker_id, uniqueness: { scope: :blocked_id }
end
