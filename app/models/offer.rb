class Offer < ApplicationRecord
  belongs_to :offering, class_name: "Proposition"
  belongs_to :offered, class_name: "Proposition"

  with_options presence: true do
    validates :offering_id, uniqueness: true
    validates :offered_id
  end
end
