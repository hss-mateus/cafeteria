require "test_helper"

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  def setup_activation
    user = create(:user, :pending_activation)
    token = user.tap(&:setup_activation).tap(&:save!).activation_token

    [user, token]
  end

  test "edit should activate account when token is valid" do
    user, token = setup_activation

    assert_changes -> { user.reload.activation_state }, from: "pending", to: "active" do
      get edit_account_activation_path(token)
    end
  end

  test "edit shouldn't activate account when token is invalid" do
    user, token = setup_activation

    token += "invalid_string"

    assert_no_changes -> { user.reload.activation_state } do
      get edit_account_activation_path(token)
    end
  end
end
