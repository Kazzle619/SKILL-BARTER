class RequestCategoriesController < ApplicationController
  prepend_before_action :authenticate_user!
  before_action :authenticate_right_user

  def create
  end

  def destroy
  end

  private

  def authenticate_right_user
    if Proposition.find(params[:proposition_id]).user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
