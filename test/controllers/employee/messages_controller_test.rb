require "test_helper"

class Employee::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user(create(:user, :employee))

    @user = create(:user, :employee)
  end

  test "should get index" do
    get employee_user_messages_path(@user)
    assert_response :success
  end

  test "should create message with valid params" do
    post employee_user_messages_path(@user), params: { message: { content: "test" } }

    assert_response :success
  end
end
