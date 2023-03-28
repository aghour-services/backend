# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    raw_response { Faker::Lorem.paragraph }
    resource_type { 'image/png' }
    resource_id { Random.hex(16) }
  end

  trait :with_article do
    article { create(:article, :with_user) }
  end
end
