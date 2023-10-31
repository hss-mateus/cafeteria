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
#  item_id     :integer
#  order_id    :integer          not null
#
# Indexes
#
#  index_order_items_on_item_id               (item_id)
#  index_order_items_on_order_id              (order_id)
#  index_order_items_on_order_id_and_item_id  (order_id,item_id) UNIQUE
#
# Foreign Keys
#
#  item_id   (item_id => items.id)
#  order_id  (order_id => orders.id)
#
FactoryBot.define do
  factory :order_item do
    order
    item
  end
end
