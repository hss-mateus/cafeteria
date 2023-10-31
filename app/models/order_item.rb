# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  quantity    :integer          default(1), not null
#  value_cents :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :integer          not null
#  product_id  :integer
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
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  before_save do
    self.value_cents = product.price_cents * quantity
    self.name = product.name
  end
end
