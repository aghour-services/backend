FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    mobile { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
