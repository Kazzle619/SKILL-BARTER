class Offer < ApplicationRecord
  # proposition#offerの処理判定で、paramsのままだと扱いにくいので属性を追加。
  attr_accessor :radio_number

  belongs_to :offering, class_name: "Proposition"
  belongs_to :offered, class_name: "Proposition"

  with_options presence: true do
    validates :offering_id, uniqueness: true
    validates :offered_id
  end
end
