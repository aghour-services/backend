FactoryBot.define do
    factory :rating do
        value { Faker::Number.between(from: 1, to: 5) }
        comment { Faker::Lorem.paragraph }
        association :user
        association :firm, :with_category
    end
end
  