FactoryBot.define do
  factory :proposition do
    title { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    deadline { Faker::Date.forward(days: 60) }
    barter_status { 1 }
    rendering_image_id { Faker::Lorem.characters(number: 30) }

    trait :with_guest do
      association :user, :guest
    end

    trait :with_chat_opponent do
      association :user, :chat_opponent
    end
  end
end
