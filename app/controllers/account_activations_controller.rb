class AccountActivationsController < ApplicationController
  def edit
    if (user = User.load_from_activation_token(params[:id]))
      user.activate!
      redirect_to new_session_path, notice: t(".success")
    else
      redirect_to root_path, alert: t(".failure")
    end
  end
end
