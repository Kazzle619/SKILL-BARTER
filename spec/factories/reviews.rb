FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.characters(number: 20) }
  end
end
