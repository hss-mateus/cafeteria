require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_path
    assert_response :success
  end

  test "should assign a session when credentials are valid" do
    create(:user) => { email: }

    post session_path, params: { user: { email:, password: "secret" } }
    assert_redirected_to root_path
  end

  test "shouldn't assign a session when credentials are invalid" do
    post session_path, params: { user: { email: "invalid@user.com", password: "secret" } }
    assert_response :unprocessable_entity
  end

  test "should delete a session" do
    login_user
    delete session_path
    assert_redirected_to root_path
  end
end
