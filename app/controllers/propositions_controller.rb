class PropositionsController < ApplicationController
  def index
    @propositions = Proposition.page(params[:page]).per(8).reverse_order
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @proposition = Proposition.find(params[:id])
    if @proposition.offering?
      @offer = @proposition.my_offer
      @offering_proposition = Proposition.find(@offer.offering_id)
    end
    @comments = @proposition.comments
    @comment = Comment.new
    @user = @proposition.user
    if @proposition.review.present?
      @review = @proposition.review
    end
  end

  def update
  end

  def destroy
  end

  def mypage_index
  end

  def offer
    @offer = Offer.new
    @new_proposition = Proposition.new
    @propositions = Proposition.where(user_id: current_user.id, barter_status: "matching")
    # 案件詳細ページから申請を出したい相手の案件idをoffered_idとして送ってある。
    @proposition = Proposition.find(params[:offered_id])
  end

  def search
  end

  def finish
  end

  def match
  end
end
