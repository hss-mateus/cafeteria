require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
  end

  test "should add a new item to order" do
    order = create(:order, status: :scratch, user: @user)

    assert_difference "order.items.count" do
      post order_items_path, params: { product_id: create(:product).id }
    end

    assert_redirected_to :current_order
  end

  test "should increase item quantity if already added" do
    order = create(:order, status: :scratch, user: @user)
    item = create(:order_item, order:, quantity: 1)

    assert_difference "item.reload.quantity" do
      post order_items_path, params: { product_id: item.product_id }
    end

    assert_redirected_to :current_order
  end

  test "should update order total value" do
    order = create(:order, status: :scratch, liquid_value_cents: 0, user: @user)
    product = create(:product, price_cents: 20)

    assert_changes "order.reload.liquid_value_cents", from: 0, to: 20 do
      post order_items_path, params: { product_id: product.id }
    end

    assert_redirected_to :current_order
  end

  test "should remove item from order" do
    order = create(:order, status: :scratch, user: @user)
    item = create(:order_item, order:)

    assert_difference "order.items.count", -1 do
      delete order_item_path(item)
    end

    assert_redirected_to :current_order
  end

  test "should decrease quantity if quantity is more than one" do
    order = create(:order, status: :scratch, user: @user)
    item = create(:order_item, order:, quantity: 2)

    assert_difference "item.reload.quantity", -1 do
      delete order_item_path(item)
    end

    assert_redirected_to :current_order
  end
end
