class BackgroundSchool < ApplicationRecord
  belongs_to :user

  enum school_type: {
    highschool: 1,
    vocational_school: 2,
    junior_college: 3,
    university: 4,
    academy: 5,
    graduate_school: 6,
  }

  enum enrollment_status: {
    currently: 1,
    graduated: 2,
    dropout: 3,
  }

  with_options presence: true do
    validates :user_id
    validates :school_name
    validates :school_type
    validates :enrollment_status
  end
end
