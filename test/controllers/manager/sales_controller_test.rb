require "test_helper"

class Manager::SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @product = create(:product)
    @sale = create(:sale)
  end

  test "should get index" do
    get manager_sales_path
    assert_response :success
  end

  test "should get new" do
    get new_manager_sale_path

    assert_response :success
  end

  test "should create sale when parameters are valid" do
    assert_difference "Sale.count" do
      post manager_sales_path, params: {
        sale: {
          product_id: @product.id,
          valid_until: 2.days.from_now,
          discount_cents: @product.price_cents - 1
        }
      }
    end

    assert_redirected_to [:manager, :sales]
  end

  test "should not create sale when parameters are invalid" do
    create(:sale, product: @product)

    assert_no_difference "Sale.count" do
      post manager_sales_path, params: {
        sale: {
          product_id: @product.id,
          valid_until: 2.days.ago,
          discount_cents: @product.price_cents + 100
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_manager_sale_path(@sale)
    assert_response :success
  end

  test "should update sale when parameters are valid" do
    assert_changes ->{ @sale.reload.values_at(:valid_until, :discount_cents) } do
      patch manager_sale_path(@sale), params: {
        sale: {
          valid_until: @sale.valid_until + 1.day,
          discount_cents: @sale.discount_cents - 1
        }
      }
    end

    assert_redirected_to [:manager, :sales]
  end

  test "should not update sale when parameters are invalid" do
    assert_no_changes ->{ @sale.reload.values_at(:valid_until, :discount_cents) } do
      patch manager_sale_path(@sale), params: {
        sale: {
          valid_until: 3.days.ago,
          discount_cents: @sale.product.price_cents + 100
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should destroy sale" do
    assert_difference "Sale.count", -1 do
      delete manager_sale_path(@sale)
    end

    assert_redirected_to [:manager, :sales]
  end
end
