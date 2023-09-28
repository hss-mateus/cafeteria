class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Sorcery::Controller

  default_form_builder CustomFormBuilder

  before_action :require_login

  private

  def not_authenticated
    redirect_to new_session_path, alert: t("sessions.unauthenticated")
  end

  def require_employee
    return if current_user&.employee?

    redirect_back_or_to root_path, alert: t("sessions.unauthorized")
  end

  def require_manager
    return if current_user&.manager?

    redirect_back_or_to root_path, alert: t("sessions.unauthorized")
  end
end
