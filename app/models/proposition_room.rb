class PropositionRoom < ApplicationRecord
  belongs_to :proposition
  belongs_to :room

  with_options presence: true do
    validates :proposition_id
    validates :room_id
  end

  validates :proposition_id, uniqueness: { scope: :room_id }
end
