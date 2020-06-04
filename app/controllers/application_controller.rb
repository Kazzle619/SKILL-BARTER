class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    # pr → proxy。長すぎてrubocopに弾かれるため短縮。
    pr = Warden::Proxy.new({}, Warden::Manager.new({})).tap { |i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => pr)
    renderer.render(*args)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :kana_name, :phone_number])
  end

  # User.currentにcurrent_userを割り当てる。
  def set_current_user
    # これが原因で退会済みユーザーでトップへredirectされていてもログインしてしまっている。後程変更予定。
    User.current = current_user
  end

  # propositions#offerはインスタンス変数が多く、様々なところでrenderしているのでメソッドを定義
  def instance_variables_for_propositions_offer
    @offer ||= Offer.new
    @new_proposition ||= Proposition.new
    @propositions ||= Proposition.where(user_id: current_user.id, barter_status: "matching")
    # 案件詳細ページから申請を出したい相手の案件idをoffered_idとして送ってある。他のアクションからrenderする際は別途用意。
    @offered_proposition ||= Proposition.find(params[:offered_id])
    @tag ||= Tag.new
  end
end
