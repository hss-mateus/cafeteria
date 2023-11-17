# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_ratings_on_product_id              (product_id)
#  index_ratings_on_user_id                 (user_id)
#  index_ratings_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#  user_id     (user_id => users.id)
#
FactoryBot.define do
  factory :rating do
    user
    product
    value { 5 }
  end
end
