# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    description { Faker::Lorem.paragraph }
  end

  trait :with_user do
    user { create(:user) }
  end
end
