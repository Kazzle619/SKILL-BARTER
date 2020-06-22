class OffersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user_for_create, only: [:create]
  # before_action :authenticate_right_user_for_destroy, only: [:destroy]

  def create
    @offered_proposition = Proposition.find(params[:proposition_id])
    # 既存の案件から申請した場合
    if params[:offering_proposition_id].present?
      offering_proposition = Proposition.find(offering_proposition_id.to_i)
      Offer.create!(
        offering_id: offering_proposition.id,
        offered_id: @offered_proposition.id,
      )
      offering_proposition.create_room_and_update_barter_statuses
      flash[:success] = "申請に成功しました。"
      redirect_to proposition_path(@offered_proposition.id)

    # 新規作成した案件から申請した場合
    else
      @new_proposition = Proposition.new(proposition_params)
      @new_proposition.user_id = current_user.id
      # 案件、案件カテゴリ、要望カテゴリ全て必要な値が揃っているかを確認する。
      # if文の条件文に書くと長すぎるのでここで変数にする。
      is_proposition_category_selected = @new_proposition.proposition_category_tag_id.present?
      is_request_category_selected = @new_proposition.request_category_tag_id.present?

      # 案件カテゴリ, 要望カテゴリが空欄の場合はまだ案件を保存したくないので.valid?で判定。
      if @new_proposition.valid? && is_proposition_category_selected && is_request_category_selected
        # 全て揃っていることを確認してようやく案件、案件カテゴリ、要望カテゴリ、スキル交換申請を保存。
        @new_proposition.save
        PropositionCategory.create!(
          proposition_id: @new_proposition.id,
          tag_id: @new_proposition.proposition_category_tag_id.to_i
        )
        RequestCategory.create!(
          proposition_id: @new_proposition.id,
          tag_id: @new_proposition.request_category_tag_id.to_i,
        )
        Offer.create!(
          offering_id: @new_proposition.id,
          offered_id: @offered_proposition.id,
        )
        @new_proposition.create_room_and_update_barter_statuses
        flash[:success] = "案件の新規作成と申請に成功しました。"
        redirect_to proposition_path(@offered_proposition.id)
      else
        @propositions = Proposition.where(user_id: current_user.id, barter_status: "matching")
        render 'propositions/offer'
      end
    end
  end

  def destroy
    offer = Offer.find(params[:id])
    # リダイレクト、ステータスの更新用にoffering, offeredそれぞれの案件インスタンスを取っておく。(どちらもステータスが変わる可能性がある)
    offered_proposition = offer.offered
    offering_proposition = offer.offering

    offer.destroy!

    offered_proposition.auto_update_barter_status
    offering_proposition.auto_update_barter_status

    flash[:success] = "交換申請を取り下げました。"
    redirect_to proposition_path(offered_proposition)
  end

  private

  def proposition_params
    params.require(:proposition).permit!
  end

  def offering_proposition_id
    params.require(:offering_proposition_id)
  end

  def authenticate_right_user_for_create
    # 既存の案件から申請する場合、申請する案件のオーナーでなければredirect。新規作成はredirectしない。
    if offering_proposition_id.present?
      offering_proposition = proposition.find(offering_proposition_id)
    end
    if user_signed_in? && offering_proposition.present? && offering_proposition.user != current_user
      flash[:warning] = "適切なユーザーではありません。"
      redirect_to root_path
    end
  end

  def authenticate_right_user_for_destroy
    offer = Offer.find(params[:id]) if params[:id].present?
    # 申請を出している側の案件のオーナーでなければredirect。
    if user_signed_in? && offer.offering.user != current_user
      flash[:warning] = "適切なユーザーではありません。"
      redirect_to root_path
    end
  end
end
