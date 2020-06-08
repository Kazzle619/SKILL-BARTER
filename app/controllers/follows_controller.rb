class FollowsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user, only: :destroy

  def create
    # フォロー相手
    @user = User.find(params[:user_id])
    if current_user.blocked_by?(@user)
      flash[:warning] = "あなたはブロックされています。"
      redirect_to request.referer
    elsif current_user.blocking.include?(@user)
      flash[:warning] = "ブロックしているユーザーです。"
      redirect_to request.referer
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
      flash[:warning] = "適切なユーザーではありません。"
      redirect_to root_path
    end
  end
end
