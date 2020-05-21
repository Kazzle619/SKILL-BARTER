class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :proposition

  with_options presence: true do
    validates :user_id
    validates :proposition_id
  end

  validates :user_id, uniqueness: { scope: :proposition_id }
end
