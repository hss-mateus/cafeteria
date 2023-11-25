# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  checkout_url         :string
#  discount_cents       :integer          default(0), not null
#  gross_value_cents    :integer          default(0), not null
#  liquid_value_cents   :integer          default(0), not null
#  observation          :text
#  payment_started_at   :datetime
#  payment_succeeded_at :datetime
#  served_at            :datetime
#  status               :integer          default("scratch"), not null
#  used_loyalty_points  :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer          not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    association :user, role: :customer
    payment_started_at { rand(1..365).days.ago }
    payment_succeeded_at { payment_started_at + 1.minute }
    served_at { payment_succeeded_at + 15.minutes }
    status { :served }
    liquid_value_cents { rand(1000..20000) }
  end
end
