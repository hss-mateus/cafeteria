require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
  end

  test "should get show without an existing order" do
    assert_difference "@user.orders.count" do
      get order_path
    end

    assert_response :success
  end

  test "should get show with an existing scratch order" do
    create(:order, user: @user, status: :scratch)

    assert_no_difference "@user.orders.count" do
      get order_path
    end

    assert_response :success
  end

  test "should get show with an existing finished order" do
    create(:order, user: @user, status: :served)

    assert_difference "@user.orders.count" do
      get order_path
    end

    assert_response :success
  end

  test "should update order status when it has at least one item" do
    order = create(:order, user: @user, items: [build(:order_item)])

    assert_changes "order.reload.status", from: "scratch", to: "payment_started" do
      put order_path
    end

    assert_redirected_to %r{https://checkout.stripe.com}
  end

  test "shouldn't update order status when there is no item" do
    order = create(:order, user: @user)

    assert_no_changes "order.reload.status" do
      put order_path
    end

    assert_redirected_to :order
  end
end
