class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_right_user, only: :destroy

  def create
    @proposition = Proposition.find(params[:proposition_id])
    @favorite = Favorite.new(
      user_id: current_user.id,
      proposition_id: params[:proposition_id],
    )
    @favorite.save!
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy!
  end

  private

  def authenticate_right_user
    if Favorite.find(params[:id]).user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
