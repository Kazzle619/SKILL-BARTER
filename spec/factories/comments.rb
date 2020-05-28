FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 20) }
    image_id { Faker::Lorem.characters(number: 30) }
  end
end
