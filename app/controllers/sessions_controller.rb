class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new(user_params)
  end

  def create
    login(user_params[:email], user_params[:password], user_params[:remember_me]) do |user, failure|
      return redirect_back_or_to root_path if user && !failure

      @user = User.new(user_params.except(:remember_me))

      flash.now[:alert] = t(".invalid")
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
