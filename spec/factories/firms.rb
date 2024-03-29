# frozen_string_literal: true

FactoryBot.define do
  factory :firm do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
    status { :published }
  end

  trait :with_category do
    category { create(:category) }
  end

end
