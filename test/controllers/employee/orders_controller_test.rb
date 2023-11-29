require "test_helper"

class Employee::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user(create(:user, :employee))
    @order = create_list(:order, 4, :payment_succeeded).first
    create_list(:order, 4, :served)
  end

  test "should get index" do
    get employee_orders_path
    assert_response :success
  end

  test "should get show" do
    get employee_order_path(@order)
    assert_response :success
  end

  test "should mark order as served" do
    assert_changes "@order.reload.status", from: "payment_succeeded", to: "served" do
      patch employee_order_path(@order)
    end

    assert_redirected_to employee_orders_path
  end
end
