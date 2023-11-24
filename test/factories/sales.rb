# == Schema Information
#
# Table name: sales
#
#  id             :integer          not null, primary key
#  discount_cents :integer          not null
#  valid_until    :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#
# Indexes
#
#  index_sales_on_product_id  (product_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#
FactoryBot.define do
  factory :sale do
    valid_until { 2.days.from_now }
    product
    discount_cents { 10_00 }
  end
end
