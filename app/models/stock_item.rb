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
class StockItem < ApplicationRecord
  has_many :movements,
           class_name: "StockMovement",
           dependent: :nullify,
           foreign_key: "item_id",
           inverse_of: :item

  enum unit: {
    g: 0,
    kg: 1,
    un: 2,
    cm: 3,
    m: 4,
    ml: 5,
    l: 6
  }

  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
