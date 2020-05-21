FactoryBot.define do
  factory :chat_message do
    content { Faker::Lorem.characters(number: 20) }
    image_id { Faker::Lorem.characters(number: 30) }
  end
end
