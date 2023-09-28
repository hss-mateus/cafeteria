require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = create(:category)
    login_user
  end

  test "should get index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    get new_category_path
    assert_response :success
  end

  test "should create with valid params" do
    assert_difference "Category.count" do
      post categories_path, params: { category: { name: "Something" }, format: :turbo_stream }
    end

    assert_response :success
  end

  test "should not create with invalid params" do
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: @category.name } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "should update with valid params" do
    patch category_path(@category), params: { category: { name: "New Name" }, format: :turbo_stream }
    assert_response :success
  end

  test "should not update with invalid params" do
    another_category = create(:category)

    patch category_path(@category), params: { category: { name: another_category.name } }
    assert_response :unprocessable_entity
  end

  test "should destroy category" do
    assert_difference "Category.count", -1 do
      delete category_path(@category), params: { format: :turbo_stream }
    end

    assert_response :success
  end
end
