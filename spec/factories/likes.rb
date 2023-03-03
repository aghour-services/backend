FactoryBot.define do
  factory :like do
    association :article
    association :user
  end
end
