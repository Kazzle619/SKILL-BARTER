class Achievement < ApplicationRecord
  mount_uploader :image_id, ImageUploader

  belongs_to :user
  has_many :achievement_categories, dependent: :destroy

  with_options presence: true do
    validates :user_id
    validates :title
    validates :introduction
  end
end
