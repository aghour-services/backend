FactoryBot.define do
  factory :device do
    token { Faker::Crypto.sha1 }
  end
end
