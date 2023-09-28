# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  price_cents :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Item < ApplicationRecord
  belongs_to :category, optional: true

  has_rich_text :description

  has_one_attached :picture

  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true
end
