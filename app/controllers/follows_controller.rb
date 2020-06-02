class FollowsController < ApplicationController
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
    # フォロー相手
    @user = User.find(params[:user_id])
    follow = Follow.find_by(
      follower_id: current_user.id,
      followed_id: @user.id,
    )
    follow.destroy!
  end
end
