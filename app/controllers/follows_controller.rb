class FollowsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user, only: :destroy

  def create
    # フォロー相手
    @user = User.find(params[:user_id])
    if current_user.blocked_by?(@user)
      redirect_to request.referer, warning: "あなたはブロックされています。"
    elsif current_user.blocking.include?(@user)
      redirect_to request.referer, warning: "ブロックしているユーザーです。"
    else
      @follow = Follow.new(
        follower_id: current_user.id,
        followed_id: @user.id,
      )
      @follow.save!
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    follow = Follow.find_by(
      follower_id: current_user.id,
      followed_id: @user.id,
    )
    follow.destroy!
  end

  private

  def authenticate_right_user
    follow = Follow.find(params[:id]) if params[:id].present?
    if user_signed_in? && follow.user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
