require "test_helper"

class Manager::StockItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:stock_item)
    login_user
  end

  test "should get index" do
    get manager_stock_items_path
    assert_response :success
  end

  test "should get new" do
    get new_manager_stock_item_path
    assert_response :success
  end

  test "should create with valid params" do
    assert_difference "StockItem.count" do
      post manager_stock_items_path, params: { stock_item: attributes_for(:stock_item) }
    end

    assert_redirected_to manager_stock_items_path
  end

  test "should not create with invalid params" do
    assert_no_difference "StockItem.count" do
      post manager_stock_items_path, params: { stock_item: { quantity: -3 } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_manager_stock_item_path(@item)
    assert_response :success
  end

  test "should update with valid params" do
    assert_changes "@item.reload.name", from: "Sample Item", to: "New Name" do
      patch manager_stock_item_path(@item), params: { stock_item: { name: "New Name" } }
    end

    assert_redirected_to manager_stock_items_path
  end

  test "should not update with invalid params" do
    assert_no_changes "@item.reload.name" do
      patch manager_stock_item_path(@item), params: { stock_item: { quantity: -3 } }
    end

    assert_response :unprocessable_entity
  end

  test "should destroy stock_item" do
    assert_difference "StockItem.count", -1 do
      delete manager_stock_item_path(@item)
    end

    assert_redirected_to manager_stock_items_path
  end
end
