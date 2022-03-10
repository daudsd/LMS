class ApplicationController < ActionController::Base
  include Pagy::Backend

  Pagy::DEFAULT[:items] = 10    # items per page
  Pagy::DEFAULT[:size]  = [1,4,4,1] # nav bar links

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private

  def set_current_user
    RequestStore[:current_user] = current_user
  end

  #accepting name (additional attribute) for create/update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
