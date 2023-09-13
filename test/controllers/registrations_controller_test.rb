require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_path
    assert_response :success
  end

  test "should create a new user when params are valid" do
    assert_difference "User.count" do
      post registration_path, params: {
        user: {
          name: "John Doe",
          email: "john@email.com",
          password: "secret",
          password_confirmation: "secret"
        }
      }
      assert_redirected_to root_path
    end
  end

  test "shouldn't create a new user when params are invalid" do
    assert_no_difference "User.count" do
      post registration_path, params: {
        user: {
          name: "",
          email: "@email.com",
          password: "secret",
          password_confirmation: "terces"
        }
      }
      assert_response :unprocessable_entity
    end
  end
end
