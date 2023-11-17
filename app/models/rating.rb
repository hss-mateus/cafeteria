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
class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :value, numericality: { in: (1..5) }

  after_commit do
    rating = Rating.where(product_id:).average(:value).to_f

    Product.update(product_id, rating:)
  end
end
