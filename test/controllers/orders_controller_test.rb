require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
  end

  test "should get index" do
    create(:order, user: @user)

    get orders_path

    assert_response :success
  end

  test "should get show with id provided" do
    order = create(:order, user: @user)

    get order_path(order)

    assert_response :success
  end

  test "should get show without an existing order" do
    assert_difference "@user.orders.count" do
      get current_order_path
    end

    assert_response :success
  end

  test "should get show with an existing scratch order" do
    create(:order, user: @user, status: :scratch)

    assert_no_difference "@user.orders.count" do
      get current_order_path
    end

    assert_response :success
  end

  test "should get show with an existing finished order" do
    create(:order, user: @user, status: :served)

    assert_difference "@user.orders.count" do
      get current_order_path
    end

    assert_response :success
  end

  test "should calculate loyalty points" do
    @user.update!(loyalty_points: 1)
    order = create(:order, status: :scratch, user: @user, items: [build(:order_item)])

    assert_difference "order.reload.used_loyalty_points" do
      put order_path(order), params: { order: { used_loyalty_points: 1 } }
    end

    assert_response :unprocessable_entity
  end

  test "should update order status when it has at least one item" do
    order = create(:order, status: :scratch, user: @user, items: [build(:order_item)])

    assert_changes "order.reload.status", from: "scratch", to: "payment_started" do
      put order_path(order, order: { start_payment: true })
    end

    assert_redirected_to %r{https://checkout.stripe.com}
  end

  test "shouldn't update order status when there is no item" do
    order = create(:order, user: @user, status: :scratch, items: [])

    assert_no_changes "order.reload.status" do
      put order_path(order)
    end

    assert_redirected_to :current_order
  end
end
