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
class StockMovement < ApplicationRecord
  belongs_to :item, optional: true, class_name: "StockItem"

  enum category: {
    inbound: 0,
    outbound: 1
  }

  validates :item, presence: true
  validates :quantity, numericality: true
  validates :unit_cost_cents, numericality: true, if: :inbound?

  before_validation :normalize_quantity, :assign_name_and_unit
  after_commit :update_item_quantity

  def total_cost
    return unless unit_cost_cents

    Money.new(cents: unit_cost_cents) * quantity
  end

  private

  def normalize_quantity
    return unless quantity

    self.quantity = inbound? ? quantity.abs : -quantity.abs
  end

  def assign_name_and_unit
    self.name = item&.name
    self.unit = item&.unit
  end

  def update_item_quantity
    item&.with_lock do
      item.quantity += quantity - (quantity_before_last_save || 0)
      item.save!
    end
  end
end
