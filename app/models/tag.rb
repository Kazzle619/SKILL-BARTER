class Tag < ApplicationRecord
  has_many :skill_categories, dependent: :destroy
  has_many :proposition_categories, dependent: :destroy
  has_many :request_categories, dependent: :destroy
  has_many :achievement_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
