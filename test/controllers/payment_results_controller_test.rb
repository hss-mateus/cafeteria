require "test_helper"

class PaymentResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
  end

  test "should get show with an payment started order" do
    order = create(:order, user: @user, status: :payment_started)

    get order_payment_result_path(order, token: order.payment_token, status: :success)

    assert_redirected_to order
  end

  test "should not get show without an scratch order" do
    order = create(:order, user: @user, status: :scratch)

    assert_no_changes "order.reload.status" do
      get order_payment_result_path(order, token: order.payment_token, status: :failed)
    end

    assert_response :not_found
  end

  test "should not get show with a invalid token" do
    order = create(:order, user: @user, status: :payment_started)

    assert_no_changes "order.reload.status" do
      get order_payment_result_path(order, token: "invalid", status: :success)
    end

    assert_redirected_to order
  end

  test "should not get show with failed status" do
    order = create(:order, user: @user, status: :payment_started)

    assert_changes "order.reload.status", from: "payment_started", to: "payment_failed" do
      get order_payment_result_path(order, token: order.payment_token, status: :failed)
    end

    assert_redirected_to order
  end
end
