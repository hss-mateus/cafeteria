class UserMailer < ApplicationMailer
  def activation_needed(user)
    @user = user

    mail to: user.email, subject: t(".subject")
  end
end
