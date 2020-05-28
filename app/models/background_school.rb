class BackgroundSchool < ApplicationRecord
  belongs_to :user

  enum school_type: {
    # 高校
    highschool: 1,
    # 専門学校
    vocational_school: 2,
    # 短大
    junior_college: 3,
    # 大学
    university: 4,
    # 大学校
    academy: 5,
    # 大学院
    graduate_school: 6,
  }

  enum enrollment_status: {
    # 在籍中
    currently: 1,
    # 卒業済
    graduated: 2,
    # 中退
    dropout: 3,
  }

  with_options presence: true do
    validates :user_id
    validates :school_name
    validates :school_type
    validates :enrollment_status
  end
end
