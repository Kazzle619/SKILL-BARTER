class BackgroundJob < ApplicationRecord
  # 入社、退社を年月のみで入力できるようにするために設定。
  attr_accessor :joining_year, :joining_month, :retirement_year, :retirement_month

  belongs_to :user

  with_options presence: true do
    validates :user_id
    validates :company_name
    validates :joining_date
  end
end
