require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product, daily_special: build(:daily_special))
    login_user
  end

  test "should get show" do
    get product_path(@product)
    assert_response :success
  end
end
