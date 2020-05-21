class AchievementCategory < ApplicationRecord
  belongs_to :achievement
  belongs_to :tag

  with_options presence: true do
    validates :achievement_id
    validates :tag_id
  end

  validates :achievement_id, uniqueness: { scope: :tag_id }
end
