require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test "should create rating" do
    user = login_user
    product = create(:product)
    order = create(:order, :served, user:, products: [product])

    assert_difference("user.ratings.count") do
      post product_ratings_path(product), params: { order_id: order.id, rating: { value: 5 } }
    end

    assert_redirected_to order
  end

  test "should update rating if already exists" do
    user = login_user
    product = create(:product)
    order = create(:order, :served, user:, products: [product])
    rating = create(:rating, user:, product:)

    assert_changes -> { rating.reload.value }, from: 5, to: 1 do
      post product_ratings_path(product), params: { order_id: order.id, rating: { value: 1 } }
    end

    assert_redirected_to order
  end

  test "should not create rating when the product wasn't purchased" do
    user = login_user
    product = create(:product)
    order = create(:order, :served, user:)

    assert_no_difference("Rating.count") do
      post product_ratings_path(product), params: { order_id: order.id, rating: { value: 1 } }
    end

    assert_response :not_found
  end
end
