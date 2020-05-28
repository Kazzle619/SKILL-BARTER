class PropositionsController < ApplicationController
  def index
    # 行が長すぎてrubocopで弾かれるので、2行で記述。必要なのは@propositions

    # まだマッチしていない案件(交換ステータスが「マッチング中」か「交換申請中」)のみ表示。
    # ORを使う場合はenumの文字列では検索できないようなので1(matching)と2(offering)で検索。
    unmatched_propositions = Proposition.where("(barter_status = ?) OR (barter_status = ?)", 1, 2)
    @propositions = unmatched_propositions.page(params[:page]).per(8).reverse_order
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @proposition = Proposition.find(params[:id])
    if @proposition.offering_to?
      @offering_proposition = @proposition.my_offering_proposition
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
