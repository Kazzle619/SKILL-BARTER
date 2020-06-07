class BlocksController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user

  def create
    # ブロック相手
    @user = User.find(params[:user_id])
    # ブロックしたらフォロー関係は解消。
    following = Follow.find_by(
      follower_id: current_user.id,
      followed_id: @user.id
    )
    followed = Follow.find_by(
      follower_id: @user.id,
      followed_id: current_user.id
    )
    if following.present?
      following.destroy! if following.present?
    end
    if followed.present?
      followed.destroy! if followed.present?
    end
    @block = Block.new(
      blocker_id: current_user.id,
      blocked_id: @user.id,
    )
    @block.save!
    redirect_to request.referer, success: "ブロックに成功しました。"
  end

  def destroy
    @user = User.find(params[:user_id])
    block = Block.find_by(
      blocker_id: current_user.id,
      blocked_id: @user.id,
    )
    block.destroy!
  end

  private

  def authenticate_right_user
    block = Block.find(params[:id]) if params[:id].present?
    if user_signed_in? && block.blocker != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
