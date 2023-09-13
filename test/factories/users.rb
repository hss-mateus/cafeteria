FactoryBot.define do
  factory :user do
    sequence(:name) { "Test User #{_1}" }
    sequence(:email) { "test_#{_1}@email.com" }
    password { "secret" }

    after(:create) { _1.update!(activation_state: "active") }

    trait :pending_activation do
      after(:create) { _1.update!(activation_state: "pending") }
    end
  end
end
