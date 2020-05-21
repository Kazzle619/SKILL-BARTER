class SkillCategory < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  with_options presence: true do
    validates :user_id
    validates :tag_id
  end

  validates :user_id, uniqueness: { scope: :tag_id }
end
