# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
