class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :configure_devise_params, if: :devise_controller?

  def configure_devise_params
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:name, :password, :password_confirmation, :invitation_token)
    end
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end
end
