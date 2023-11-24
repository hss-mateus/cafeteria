# == Schema Information
#
# Table name: alergenic_ingredients
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#
# Indexes
#
#  index_alergenic_ingredients_on_product_id  (product_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#
FactoryBot.define do
  factory :alergenic_ingredient do
    product
    name { "Nuts" }
  end
end
