class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :kana_name, :phone_number])
  end

  # User.currentにcurrent_userを割り当てる。
  def set_current_user
    User.current = current_user
  end
end
