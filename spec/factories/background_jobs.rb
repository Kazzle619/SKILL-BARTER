FactoryBot.define do
  factory :background_job do
    company_name { Faker::Company.name }
    department { Faker::Commerce.department }
    position { Faker::Job.position }
    joining_date { Faker::Date.between(from: 5.years.ago, to: 4.years.ago) }
    retirement_date { Faker::Date.between(from: 2.years.ago, to: 1.year.ago) }
  end
end
