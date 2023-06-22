# frozen_string_literal: true

FactoryBot.define do
    factory :avatar do
      raw_response { Faker::Lorem.paragraph }
      avatar_id { Random.hex(2) }
      avatar_type { 'image/png' }
      avatar_url { 'https://i.imgur.com/1zAhjUi.jpg' }
    end
end
  