class UserPrefecture < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture

  with_options presence: true do
    validates :user_id
    validates :prefecture_id
  end

  validates :user_id, uniqueness: { scope: :prefecture_id }
end
