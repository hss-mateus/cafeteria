require "test_helper"

class StockItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:stock_item)
    login_user
  end

  test "should get index" do
    get stock_items_path
    assert_response :success
  end

  test "should get new" do
    get new_stock_item_path
    assert_response :success
  end

  test "should create with valid params" do
    assert_difference "StockItem.count" do
      post stock_items_path, params: { stock_item: attributes_for(:stock_item) }
    end

    assert_redirected_to stock_items_path
  end

  test "should not create with invalid params" do
    assert_no_difference "StockItem.count" do
      post stock_items_path, params: { stock_item: { quantity: -3 } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_stock_item_path(@item)
    assert_response :success
  end

  test "should update with valid params" do
    assert_changes "@item.reload.name", from: "Sample Item", to: "New Name" do
      patch stock_item_path(@item), params: { stock_item: { name: "New Name" } }
    end

    assert_redirected_to stock_items_path
  end

  test "should not update with invalid params" do
    assert_no_changes "@item.reload.name" do
      patch stock_item_path(@item), params: { stock_item: { quantity: -3 } }
    end

    assert_response :unprocessable_entity
  end

  test "should destroy stock_item" do
    assert_difference "StockItem.count", -1 do
      delete stock_item_path(@item)
    end

    assert_redirected_to stock_items_path
  end
end
