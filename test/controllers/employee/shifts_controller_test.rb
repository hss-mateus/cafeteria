require "test_helper"

class Employee::ShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, role: :employee)
    login_user(@user)
    @shift = create(:shift, user: @user)
  end

  test "should get index" do
    get employee_shifts_path
    assert_response :success
  end

  test "should not get index without employee role" do
    @user.customer!
    get employee_shifts_path
    assert_redirected_to root_path
  end
end
