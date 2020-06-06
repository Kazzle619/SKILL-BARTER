class FollowsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user, only: :destroy

  def create
    # フォロー相手
    @user = User.find(params[:user_id])
    @follow = Follow.new(
      follower_id: current_user.id,
      followed_id: @user.id,
    )
    @follow.save!
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy!
  end

  private

  def authenticate_right_user
    if Follow.find(params[:id]).user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
