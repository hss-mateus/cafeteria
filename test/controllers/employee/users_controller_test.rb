require "test_helper"

class Employee::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user(create(:user, :employee))
  end

  test "should get index" do
    get employee_users_path
    assert_response :success
  end
end
