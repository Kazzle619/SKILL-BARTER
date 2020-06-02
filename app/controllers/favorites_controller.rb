class FavoritesController < ApplicationController
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
      proposition_id: params[:proposition_id],
    )
    favorite.destroy!
  end
end
