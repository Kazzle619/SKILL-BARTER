class RequestCategory < ApplicationRecord
  belongs_to :proposition
  belongs_to :tag

  with_options presence: true do
    validates :proposition_id
    validates :tag_id
  end

  validates :proposition_id, uniqueness: { scope: :tag_id }
end
