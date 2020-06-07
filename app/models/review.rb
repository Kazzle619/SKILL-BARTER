class Review < ApplicationRecord
  belongs_to :user
  belongs_to :proposition

  with_options presence: true do
    validates :user_id
    validates :proposition_id
    validates :comment
    validates :rate
  end

  validates :user_id, uniqueness: { scope: :proposition_id }
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }
end
