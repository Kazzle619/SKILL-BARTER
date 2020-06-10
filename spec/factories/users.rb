FactoryBot.define do
  factory :user do
    name { "#{Faker::Lorem.characters(number: 5)} #{Faker::Lorem.characters(number: 5)}" }
    kana_name { "#{Faker::Lorem.characters(number: 5)} #{Faker::Lorem.characters(number: 5)}" }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 40) }
    phone_number { Faker::PhoneNumber.cell_phone.delete("-") }
    introduction { Faker::Lorem.characters(number: 30) }
    profile_image_id { Faker::Lorem.characters(number: 30) }
    user_status { rand(1..2) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
