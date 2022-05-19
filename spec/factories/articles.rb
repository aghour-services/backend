# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    description { Faker::Lorem.paragraph }
  end

  trait :published do
    status { :published }
  end
end
