require "test_helper"

class Manager::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product, daily_special: build(:daily_special))
    login_user(create(:user, :manager))
  end

  test "should get new" do
    get new_manager_product_path
    assert_response :success
  end

  test "should create with valid params" do
    assert_difference "Product.count" do
      post manager_products_path, params: { product: attributes_for(:product).merge(category_id: create(:category).id) }
    end

    assert_redirected_to categories_path
  end

  test "should not create with invalid params" do
    assert_no_difference "Product.count" do
      post manager_products_path, params: {
        product: {
          name: @product.name,
          daily_special_attributes: {
            discount_cents: 99999999
          }
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_manager_product_path(@product)
    assert_response :success
  end

  test "should update with valid params" do
    patch manager_product_path(@product), params: { product: { name: "New Name" } }
    assert_redirected_to categories_path
  end

  test "should not update with invalid params" do
    another_product = create(:product)

    patch manager_product_path(@product), params: { product: { name: another_product.name } }
    assert_response :unprocessable_entity
  end

  test "should destroy product" do
    assert_difference "Product.count", -1 do
      delete manager_product_path(@product)
    end

    assert_redirected_to categories_path
  end
end
