class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_with_token
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :bio, :photo, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  def authenticate_with_token
    return unless params[:api_token]

    user = User.find_by_api_token(params[:api_token])
    sign_in(user)
  end
end
