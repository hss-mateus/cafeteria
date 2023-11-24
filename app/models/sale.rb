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
class Sale < ApplicationRecord
  belongs_to :product

  validates :discount_cents, :valid_until, presence: true
  validate :discount_less_than_product_price
  validate :valid_until_in_future
  validate :no_active_sales
  validate :still_active, on: :update

  scope :active, ->{ where(valid_until: Time.zone.today..) }

  after_save do
    Sale::RecalculateOrdersJob.set(wait_until: valid_until.at_end_of_day).perform_later(self)
  end

  def active?
    !valid_until.past?
  end

  private

  def discount_less_than_product_price
    return if errors[:discount_cents].any?
    return if discount_cents < product.price_cents

    errors.add(:discount_cents, :less_than, count: product.price_cents)
  end

  def valid_until_in_future
    return if errors[:valid_until].any?
    return unless valid_until.past?

    errors.add(:valid_until, :greater_than, count: I18n.l(valid_until))
  end

  def no_active_sales
    return if errors[:product_id].any?
    return unless product.sales.active.excluding(self).any?

    errors.add(:product_id, :already_active)
  end

  def still_active
    return if active?

    errors.add(:base, :inactive)
  end
end
