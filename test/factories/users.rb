# == Schema Information
#
# Table name: users
#
#  id                           :bigint           not null, primary key
#  activation_state             :string
#  activation_token             :string
#  activation_token_expires_at  :datetime
#  crypted_password             :string
#  email                        :string
#  name                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  salt                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token   (activation_token)
#  index_users_on_email              (email) UNIQUE
#  index_users_on_remember_me_token  (remember_me_token)
#
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
