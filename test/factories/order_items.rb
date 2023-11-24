# == Schema Information
#
# Table name: order_items
#
#  id                 :integer          not null, primary key
#  discount_cents     :integer          default(0), not null
#  gross_value_cents  :integer          default(0), not null
#  liquid_value_cents :integer          not null
#  name               :string           not null
#  quantity           :integer          default(1), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_id           :integer          not null
#  product_id         :integer
#
# Indexes
#
#  index_order_items_on_order_id                 (order_id)
#  index_order_items_on_order_id_and_product_id  (order_id,product_id) UNIQUE
#  index_order_items_on_product_id               (product_id)
#
# Foreign Keys
#
#  order_id    (order_id => orders.id)
#  product_id  (product_id => products.id)
#
FactoryBot.define do
  factory :order_item do
    order
    product
  end
end
