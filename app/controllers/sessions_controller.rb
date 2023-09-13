class SessionsController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    login(user_params[:email], user_params[:password], user_params[:remember_me]) do |user, failure|
      return redirect_back_or_to root_path if user && !failure

      @user = User.new(user_params.except(:remember_me))

      message =
        if failure == :inactive
          t(".inactive")
        else
          t(".invalid")
        end

      flash.now[:alert] = message
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :email,
      :password,
      :remember_me
    )
  end
end
