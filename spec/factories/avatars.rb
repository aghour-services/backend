# frozen_string_literal: true

FactoryBot.define do
  factory :avatar do
    raw_response { Faker::Lorem.paragraph }
    resource_id { Random.hex(2) }
    resource_type { 'image/png' }
    url { 'https://i.imgur.com/1zAhjUi.jpg' }
  end
end
  