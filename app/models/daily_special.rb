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
class DailySpecial < ApplicationRecord
  belongs_to :product

  validates :week_day, numericality: { in: (0..6) }
  validates :discount_cents, numericality: { greater_than: 0 }
  validate :discount_less_than_product_price

  private

  def discount_less_than_product_price
    return if product&.price_cents && discount_cents && product.price_cents > discount_cents

    count = ApplicationController.helpers.cents_to_currency(product.price_cents)
    errors.add(:discount_cents, :less_than, count:)
  end
end
