class BlocksController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user

  def create
  end

  def destroy
  end

  private

  def authenticate_right_user
    block = Block.find(params[:id]) if params[:id].present?
    if user_signed_in? && block.blocker != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
