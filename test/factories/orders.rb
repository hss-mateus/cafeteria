# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  observation       :text
#  status            :integer          default("scratch"), not null
#  total_value_cents :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer          not null
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
    user
  end
end
