class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Sorcery::Controller

  default_form_builder CustomFormBuilder

  private

  def not_authenticated
    redirect_to new_session_path, alert: t("sessions.unauthenticated")
  end
end
