# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: sign_in_params[:email])
    if user.present? && user.user_status == "unsubscribed"
      # application_controllerのset_current_userにより自動的にログインしてしまっている様子なので、一度ログアウト処理を挟む。
      # 後程変更予定。
      sign_out user
      flash[:danger] = "退会済みのユーザーです。"
      redirect_to root_path
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest
    guest = User.guest
    sign_in guest
    flash[:info] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end

  def chat_opponent
    chat_opponent = User.chat_opponent
    sign_in chat_opponent
    flash[:info] = 'テストチャットユーザーとしてログインしました。'
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
