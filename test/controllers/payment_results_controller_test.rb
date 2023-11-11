require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
  end

  test "should get show with an payment started order" do
    order = create(:order, user: @user, status: :payment_started)

    get current_order_payment_result_path(token: order.payment_token, status: :success)

    assert_redirected_to order
  end

  test "should not get show without an payment started order" do
    order = create(:order, user: @user, status: :scratch)

    assert_no_changes "order.reload.status" do
      get current_order_payment_result_path(token: order.payment_token, status: :failed)
    end

    assert_response :not_found
  end

  test "should not get show with a invalid token" do
    order = create(:order, user: @user, status: :payment_started)

    assert_changes "order.reload.status", from: "payment_started", to: "scratch" do
      get current_order_payment_result_path(token: "invalid", status: :success)
    end

    assert_redirected_to :current_order
  end

  test "should not get show with failed status" do
    order = create(:order, user: @user, status: :payment_started)

    assert_changes "order.reload.status", from: "payment_started", to: "scratch" do
      get current_order_payment_result_path(token: order.payment_token, status: :failed)
    end

    assert_redirected_to :current_order
  end
end
