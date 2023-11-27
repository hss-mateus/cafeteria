# == Schema Information
#
# Table name: daily_specials
#
#  id             :integer          not null, primary key
#  discount_cents :integer          not null
#  week_day       :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#
# Indexes
#
#  index_daily_specials_on_product_id  (product_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#
FactoryBot.define do
  factory :daily_special do
    product
    week_day { 1 }
    discount_cents { 1 }
  end
end
