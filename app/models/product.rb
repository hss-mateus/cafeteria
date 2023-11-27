# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price_cents :integer          not null
#  rating      :float            default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
class Product < ApplicationRecord
  belongs_to :category

  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items
  has_many :ratings, dependent: :destroy
  has_many :alergenic_ingredients, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_one :daily_special, dependent: :destroy

  accepts_nested_attributes_for :alergenic_ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :daily_special, update_only: true, allow_destroy: true

  has_rich_text :description

  has_one_attached :picture

  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true
  validates :picture, content_type: [:png, :jpeg, :jpg, :webp]

  after_commit :recalculate_orders, on: :update
  after_commit :destroy_order_items, on: :destroy

  def discount?
    sales.active.any? || today_daily_special.present?
  end

  def today_daily_special
    return unless daily_special&.week_day == Time.zone.today.wday

    daily_special
  end

  def discount_cents
    sale_discount = sales.active.first&.discount_cents
    daily_special_discount = today_daily_special&.discount_cents

    [sale_discount, daily_special_discount, 0].compact.max
  end

  def discounted_price_cents
    price_cents - discount_cents
  end

  private

  def recalculate_orders
    orders.scratch.each(&:calculate_values!)
  end

  def destroy_order_items
    scope = order_items.joins(:order).where(order: { status: [:scratch, :payment_failed] })
    order_ids = scope.pluck(:order_id)
    scope.destroy_all

    Order.where(id: order_ids).find_each(&:calculate_values!)
  end
end
