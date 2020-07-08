class FavoritesController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user, only: :destroy

  def create
    @proposition = Proposition.find(params[:proposition_id])
    @favorite = Favorite.new(
      user_id: current_user.id,
      proposition_id: params[:proposition_id],
    )
    @favorite.save!
  end

  def destroy
    @proposition = Proposition.find(params[:proposition_id])
    favorite = Favorite.find_by(
      user_id: current_user.id,
      proposition_id: @proposition.id
    )
    favorite.destroy!
  end

  # private

  # def authenticate_right_user
  #   favorite = Favorite.find(params[:id]) if params[:id].present?
  #   if user_signed_in? && favorite.user != current_user
  #     flash[:warning] = "適切なユーザーではありません。"
  #     redirect_to root_path
  #   end
  # end
end
