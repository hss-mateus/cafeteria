# == Schema Information
#
# Table name: stock_movements
#
#  id              :integer          not null, primary key
#  category        :integer          default("inbound"), not null
#  name            :string           not null
#  performed_at    :datetime         not null
#  quantity        :float            not null
#  unit            :string           not null
#  unit_cost_cents :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_id         :integer
#
# Indexes
#
#  index_stock_movements_on_item_id  (item_id)
#
# Foreign Keys
#
#  item_id  (item_id => stock_items.id)
#
FactoryBot.define do
  factory :stock_movement do
    category { :inbound}
    quantity { 1 }
    name { "Sample Item" }
    unit { "un" }
    unit_cost_cents { 1 }
    item factory: :stock_item
    performed_at { Time.zone.now }
  end
end
