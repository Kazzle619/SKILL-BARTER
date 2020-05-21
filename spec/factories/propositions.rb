FactoryBot.define do
  factory :proposition do
    title { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    deadline { Faker::Date.forward(days: 60) }
    barter_status { rand(1..3) }
    rendering_image_id { Faker::Lorem.characters(number: 30) }
  end
end
