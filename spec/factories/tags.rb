FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number: 10) }
  end
end
