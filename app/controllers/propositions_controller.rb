class PropositionsController < ApplicationController
  def index
    # 行が長すぎてrubocopで弾かれるので、2行で記述。必要なのは@propositions

    # まだマッチしていない案件(交換ステータスが「マッチング中」か「交換申請中」)のみ表示。
    # ORを使う場合はenumの文字列では検索できないようなので1(matching)と2(offering)で検索。
    unmatched_propositions = Proposition.where("(barter_status = ?) OR (barter_status = ?)", 1, 2)
    @propositions = unmatched_propositions.page(params[:page]).per(8).reverse_order
  end

  def create
    @proposition = Proposition.new(proposition_params)
    @proposition.user_id = current_user.id
    # 案件、案件カテゴリ、要望カテゴリ全て必要な値が揃っているかを確認する。
    # if文の条件文に書くと長すぎるのでここで変数にする。
    is_proposition_category_selected = @proposition.proposition_category_tag_id.present?
    is_request_category_selected = @proposition.request_category_tag_id.present?

    # 案件カテゴリ, 要望カテゴリが空欄の場合はまだ案件を保存したくないので.valid?で判定。
    if @proposition.valid? && is_proposition_category_selected && is_request_category_selected
      # 全て揃っていることを確認してようやく案件、案件カテゴリ、要望カテゴリ、スキル交換申請を保存。
      @proposition.save
      PropositionCategory.create(proposition_id: @proposition.id,
                                 tag_id: @proposition.proposition_category_tag_id.to_i)
      RequestCategory.create(proposition_id: @proposition.id,
                             tag_id: @proposition.request_category_tag_id.to_i)
      redirect_to finish_proposition_path(@proposition)
    else
      render 'propositions/new'
    end
  end

  def new
    @proposition = Proposition.new
    @tag = Tag.new
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
    @propositions = current_user.propositions
  end

  def offer
    # パラメータが多く、他でrenderされることも多いのでapplication_controllerに以下のメソッドを定義。
    instance_variables_for_propositions_offer
  end

  def search
  end

  def finish
    @proposition = Proposition.find(params[:id])
  end

  def match
  end

  private

  # 新規案件作成フォームに入力した値
  # 案件カテゴリとして選んだタグのidがparams[:proposition][:proposition_category_id]として飛んできている。
  # 要望カテゴリとして選んだタグのidがparams[:proposition][:request_category_id]として飛んできている。
  def proposition_params
    params.require(:proposition).permit(:title,
                                        :introduction,
                                        :deadline,
                                        :rendering_image,
                                        :proposition_category_tag_id,
                                        :request_category_tag_id)
  end
end
