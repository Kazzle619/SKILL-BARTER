class BlocksController < ApplicationController
  prepend_before_action :authenticate_user!
  before_action :authenticate_right_user

  def create
  end

  def destroy
  end

  private

  def authenticate_right_user
    if Block.find(params[:id]).blocker != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
