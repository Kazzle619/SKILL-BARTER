class ChatMessage < ApplicationRecord
  attachment :image

  belongs_to :proposition
  belongs_to :room

  with_options presence: true do
    validates :proposition_id
    validates :room_id
  end
end
