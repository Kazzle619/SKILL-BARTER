class BackgroundJob < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :user_id
    validates :company_name
    validates :joining_date
  end
end
