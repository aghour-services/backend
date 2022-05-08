# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    after(:build) do |category|
      category.icon.attach(
        io: File.open(Rails.root.join('spec', 'fixture_files', '1.jpeg')),
        filename: 'test.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
