require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:item)
    login_user
  end

  test "should get show" do
    get item_path(@item)
    assert_response :success
  end

  test "should get new" do
    get new_item_path
    assert_response :success
  end

  test "should create with valid params" do
    assert_difference "Item.count" do
      post items_path, params: { item: attributes_for(:item).merge(category_id: create(:category).id) }
    end

    assert_redirected_to categories_path
  end

  test "should not create with invalid params" do
    assert_no_difference "Item.count" do
      post items_path, params: { item: { name: @item.name } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_item_path(@item)
    assert_response :success
  end

  test "should update with valid params" do
    patch item_path(@item), params: { item: { name: "New Name" } }
    assert_redirected_to categories_path
  end

  test "should not update with invalid params" do
    another_item = create(:item)

    patch item_path(@item), params: { item: { name: another_item.name } }
    assert_response :unprocessable_entity
  end

  test "should destroy item" do
    assert_difference "Item.count", -1 do
      delete item_path(@item)
    end

    assert_redirected_to categories_path
  end
end
