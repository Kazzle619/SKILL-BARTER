class PropositionsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :index, :show]
  before_action :authenticate_right_user, only: [:finish, :match, :edit, :update, :destroy]
  before_action :authenticate_not_blocked, only: [:show]
  before_action :check_proposition_for_chat, only: [:destroy]

  def index
    @search = Proposition.ransack(params[:q])
    # 長すぎてrubocopで弾かれるのでuser_statusの条件は数字で。1→subscribing。
    @propositions = @search.result.includes(
      :proposition_category_tags,
      :request_category_tags,
    ).joins(:user).where(users: { user_status: 1 }).page(params[:page]).per(8).reverse_order
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
      PropositionCategory.create(
        proposition_id: @proposition.id,
        tag_id: @proposition.proposition_category_tag_id.to_i
      )
      RequestCategory.create(
        proposition_id: @proposition.id,
        tag_id: @proposition.request_category_tag_id.to_i,
      )
      flash[:success] = "案件の新規作成に成功しました。"
      redirect_to finish_proposition_path(@proposition)
    else
      @tag = Tag.new
      render 'propositions/new'
    end
  end

  def new
    @proposition = Proposition.new
  end

  def edit
    @proposition = Proposition.find(params[:id])
    # 今は1つしか登録できないようにしてあるのでこれで。後程変更予定。
    proposition_category = @proposition.proposition_categories[0]
    request_category = @proposition.request_categories[0]
    @proposition.proposition_category_tag_id = proposition_category.tag_id
    @proposition.request_category_tag_id = request_category.tag_id
  end

  def show
    @proposition = Proposition.find(params[:id])
    # 長すぎてrubocopで弾かれるのでif文で
    if @proposition.offering_to?
      @offering_proposition = @proposition.my_offering_proposition
    end
    @comments = @proposition.comments
    @comment = Comment.new
    @user = @proposition.user
    @review = @proposition.review if @proposition.review.present?
    if user_signed_in?
      @follow = Follow.find_by(
        follower_id: current_user.id,
        followed_id: @user.id,
      )
      @block = Block.find_by(
        blocker_id: current_user.id,
        blocked_id: @user.id,
      )
      @favorite = Favorite.find_by(
        user_id: current_user.id,
        proposition_id: @proposition.id,
      )
    end
    @room = @proposition.room
    @chat_messages = ChatMessage.where(room_id: @room.id) if @room.present?
  end

  def update
    @proposition = Proposition.find(params[:id])
    category_tag_ids
    # 案件、案件カテゴリ、要望カテゴリ全て必要な値が揃っているかを確認する。
    # if文の条件文に書くと長すぎるのでここで変数にする。
    is_proposition_category_selected = @proposition_category_tag_id.present?
    is_request_category_selected = @request_category_tag_id.present?
    # 長すぎてrubocopに弾かれるのでここでカテゴリタグの選択確認だけまとめる。
    is_categories_both_selected = is_proposition_category_selected && is_request_category_selected

    if is_categories_both_selected && @proposition.update(proposition_params)
      # 全て揃っていることを確認してようやく案件カテゴリ、要望カテゴリを更新。
      @proposition.proposition_categories[0].update(tag_id: @proposition_category_tag_id)
      @proposition.request_categories[0].update(tag_id: @request_category_tag_id)
      flash[:success] = "案件の更新に成功しました"
      redirect_to finish_proposition_path(@proposition)
    else
      @tag = Tag.new
      render 'propositions/edit'
    end
  end

  def destroy
    proposition = Proposition.find(params[:id])
    if proposition.is_matched?
      flash[:warning] = "マッチングしている案件は削除できません。"
      redirect_to request.referer
    else
      # 削除すると関連するofferも消えるので、申請が来ていた案件のステータスを削除後に更新。
      # ここで取っておかないと、削除後はofferersが空になってしまう。to_aとしないと同じく消えてしまう。
      update_needed_propositions = proposition.offerers.to_a
      proposition.destroy!
      if update_needed_propositions.present?
        update_needed_propositions.each do |offerer|
          offerer.auto_update_barter_status
        end
      end
      flash[:success] = "案件の削除に成功しました。"
      redirect_to mypage_index_propositions_path
    end
  end

  def mypage_index
    @propositions = current_user.propositions
  end

  def offer
    @new_proposition = Proposition.new
    @propositions = Proposition.where(user_id: current_user.id, barter_status: "matching")
    @offered_proposition = Proposition.find(params[:offered_id])
  end

  def search
    @search = Proposition.ransack(search_params)
    # 長すぎてrubocopで弾かれるのでuser_statusの条件は数字で。1→subscribing。
    @propositions = @search.result.includes(
      :proposition_category_tags,
      :request_category_tags,
    ).joins(:user).where(users: { user_status: 1 }).page(params[:page]).per(8).reverse_order
  end

  def finish
    @proposition = Proposition.find(params[:id])
    @previous_path = Rails.application.routes.recognize_path(request.referer)
    @favorite = Favorite.find_by(user_id: current_user.id, proposition_id: @proposition.id)
  end

  def match
    my_proposition = Proposition.find(params[:id])
    # wc = wishing_category。長すぎてrubocopに弾かれるので短縮。
    wc = my_proposition.request_categories[0].tag_id
    # wp = wishing_proposition。長すぎてrubocopに弾かれるので短縮。
    wp = Proposition.joins(:proposition_categories).where(proposition_categories: { tag_id: wc })
    @best_match_propositions = []
    @half_match_propositions = []
    wp.each do |proposition|
      if proposition.request_categories[0].tag_id == my_proposition.proposition_categories[0].tag_id
        @best_match_propositions.append(proposition)
      else
        @half_match_propositions.append(proposition)
      end
    end
  end

  private

  # 案件カテゴリとして選んだタグのidがparams[:proposition][:proposition_category_tag_id]として飛んできている。
  # 要望カテゴリとして選んだタグのidがparams[:proposition][:request_category_tag_id]として飛んできている。
  def proposition_params
    params.require(:proposition).permit!
  end

  def search_params
    params.require(:q).permit!
  end

  def category_tag_ids
    @proposition_category_tag_id = params[:proposition][:proposition_category_tag_id]
    @request_category_tag_id = params[:proposition][:request_category_tag_id]
  end

  def authenticate_right_user
    proposition = Proposition.find(params[:id]) if params[:id].present?
    if user_signed_in? && proposition.user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end

  def authenticate_not_blocked
    proposition = Proposition.find(params[:id]) if params[:id].present?
    if user_signed_in? && current_user.blocked_by?(proposition.user)
      redirect_to request.referer, warning: "あなたはブロックされています。"
    end
  end

  def check_proposition_for_chat
    proposition = Proposition.find(params[:id])
    # チャットテスト用案件の場合はリダイレクト
    if [1, 20].include?(proposition.id)
      flash[:warning] = "チャットテスト用の案件は削除できません。"
      redirect_to root_path
    end
  end
end
