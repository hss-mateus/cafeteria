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
FactoryBot.define do
  factory :product do
    category
    sequence(:name) { "Product ##{_1}" }
    price_cents { 100_00 }
  end
end
