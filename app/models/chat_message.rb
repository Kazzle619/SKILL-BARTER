class ChatMessage < ApplicationRecord
  attachment :image

  belongs_to :user
  belongs_to :room

  with_options presence: true do
    validates :user_id
    validates :room_id
  end
end
