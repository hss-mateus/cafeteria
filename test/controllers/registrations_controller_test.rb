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

  test "should get edit" do
    login_user

    get edit_registration_path
    assert_response :success
  end

  test "should update user when params are valid" do
    params = {
      name: "New Name",
      email: "new@email.com",
      password: "secret",
      password_confirmation: "secret"
    }

    user = login_user

    put registration_path, params: { user: params }

    assert_equal params[:name], user.reload.name
    assert_redirected_to edit_registration_path
  end

  test "should not update user when params are invalid" do
    params = {
      name: "A" * 51,
      email: "invalidemail",
      password: "short",
      password_confirmation: "wrong"
    }

    user = login_user

    assert_no_changes "user.reload.attributes" do
      put registration_path, params: { user: params }
    end

    assert_response :unprocessable_entity
  end
end
