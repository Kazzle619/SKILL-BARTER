FactoryBot.define do
  factory :background_school do
    school_name { Faker::Educator.university }
    school_type { 4 }
    department { Faker::Educator.subject }
    enrollment_status { 2 }
  end
end
