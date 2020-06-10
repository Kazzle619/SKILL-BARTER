FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.characters(number: 20) }
    rate { rand(1..5) }
  end
end
