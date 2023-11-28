# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  crypted_password             :string
#  email                        :string
#  loyalty_points               :integer          default(0), not null
#  name                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  role                         :integer          default("customer"), not null
#  salt                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_email              (email) UNIQUE
#  index_users_on_remember_me_token  (remember_me_token)
#
FactoryBot.define do
  factory :user do
    sequence(:name) { "Test User #{_1}" }
    sequence(:email) { "test_#{_1}@email.com" }
    password { "secret" }
    role { :manager }
  end
end
