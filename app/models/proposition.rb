class Proposition < ApplicationRecord
  belongs_to :user

  attachment :rendering_image

  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :proposition_categories, dependent: :destroy
  has_many :request_categories, dependent: :destroy
  has_many :proposition_rooms, dependent: :destroy
  has_many :chat_messages, dependent: :destroy

  enum barter_status: {
    # 未マッチング
    matching: 1,
    # マッチング済
    matched: 2,
    # 交換済み(履歴へ)
    bartered: 3,
  }

  with_options presence: true do
    validates :user_id
    validates :title
    validates :introduction
    validates :barter_status
  end
end
