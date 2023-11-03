# == Schema Information
#
# Table name: stock_items
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  quantity   :float            not null
#  unit       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :stock_item do
    name { "Sample Item" }
    unit { :un }
    quantity { 1 }
  end
end
