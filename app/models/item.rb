# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price_cents :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
class Item < ApplicationRecord
  belongs_to :category

  has_many :order_items

  has_rich_text :description

  has_one_attached :picture

  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true
  validates :picture, content_type: [:png, :jpeg, :jpg, :webp]

  after_commit :destroy_order_items, on: :destroy

  private

  def destroy_order_items
    order_items
      .joins(:order)
      .where(order: { status: [:scratch, :payment_failed] })
      .destroy_all
  end
end
