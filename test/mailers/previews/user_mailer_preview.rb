class UserMailerPreview < ActionMailer::Preview
  def activation_needed
    user = User.last.tap(&:setup_activation)

    UserMailer.activation_needed(user)
  end
end
