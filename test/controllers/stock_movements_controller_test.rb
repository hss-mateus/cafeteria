require "test_helper"

class StockMovementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movement = create(:stock_movement)
    @user = login_user
  end

  test "should get index" do
    get stock_movements_path
    assert_response :success
  end

  test "should not get index without manager role" do
    @user.employee!

    get stock_movements_path
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_stock_movement_path
    assert_response :success
  end

  test "should create with valid params" do
    item_id = create(:stock_item).id

    assert_difference "StockMovement.count" do
      post stock_movements_path, params: { stock_movement: attributes_for(:stock_movement).merge(item_id:) }
    end

    assert_redirected_to stock_movements_path
  end

  test "should not create with invalid params" do
    assert_no_difference "StockMovement.count" do
      post stock_movements_path, params: { stock_movement: { quantity: -3 } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_stock_movement_path(@movement)
    assert_response :success
  end

  test "should update with valid params" do
    new_item = create(:stock_item, name: "New Item")

    assert_changes "@movement.reload.name", from: "Sample Item", to: "New Item" do
      patch stock_movement_path(@movement), params: { stock_movement: { item_id: new_item.id } }
    end

    assert_redirected_to stock_movements_path
  end

  test "should not update with invalid params" do
    assert_no_changes "@movement.reload.name" do
      patch stock_movement_path(@movement), params: { stock_movement: { category: :inbound, unit_cost_cents: nil } }
    end

    assert_response :unprocessable_entity
  end

  test "should destroy stock_movement" do
    assert_difference "StockMovement.count", -1 do
      delete stock_movement_path(@movement)
    end

    assert_redirected_to stock_movements_path
  end
end
