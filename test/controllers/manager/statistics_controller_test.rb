require "test_helper"

class Manager::StatisticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login_user
    create_list(:order_item, 20)

    get manager_statistics_path
    assert_response :success
  end
end
