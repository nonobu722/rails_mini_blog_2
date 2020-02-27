class ApplicationController < ActionController::Base
  if Rails.env.production?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[user_id name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[profile blog_url])
  end
end
