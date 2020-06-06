class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_matching_user

  def new
    @proposition = Proposition.find(params[:proposition_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.proposition_id = params[:proposition_id].to_i
    if @review.save
      # 状況に合わせて案件の交換ステータスを自動更新。
      reviewed_proposition = @review.proposition
      reviewers_bartering_proposition = reviewed_proposition.offering
      reviewed_proposition.auto_update_barter_status
      reviewers_bartering_proposition.auto_update_barter_status

      redirect_to proposition_path(params[:proposition_id].to_i), success: "レビューの作成に成功しました。"
    else
      @proposition = Proposition.find(params[:proposition_id])
      render 'reviews/new', danger: "レビューの作成に失敗しました。"
    end
  end

  def edit
    @proposition = Proposition.find(params[:proposition_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to proposition_path(params[:proposition_id].to_i), success: "レビューの編集に成功しました。"
    else
      @proposition = Proposition.find(params[:proposition_id])
      render 'reviews/edit', danger: "レビューの編集に失敗しました。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

  def authenticate_matching_user
    proposition = Proposition.find(params[:proposition_id])
    if !proposition.is_matched?
      redirect_to root_path, warning: "この案件はマッチングしていないためレビューできません。"
    elsif user_signed_in? && proposition.offering.user != current_user
      redirect_to root_path, warning: "マッチング相手のみ編集可能です。"
    end
  end
end
