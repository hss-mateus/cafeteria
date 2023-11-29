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
end
