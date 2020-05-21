class Room < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  has_many :proposition_rooms, dependent: :destroy
end
