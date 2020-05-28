FactoryBot.define do
  factory :achievement do
    title { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    image_id { Faker::Lorem.characters(number: 30) }
  end
end
