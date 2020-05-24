class ReviewsController < ApplicationController
  def new
    @proposition = Proposition.find(params[:proposition_id])
    # 「スキル交換を完了する」ボタンから来ているので、ここでbarter_statusを"bartered"に変更。
    @proposition.barter_status = "bartered"
    @proposition.save

    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.proposition_id = params[:proposition_id].to_i

    if @review.save
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
end
