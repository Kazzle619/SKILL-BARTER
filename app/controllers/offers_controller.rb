class OffersController < ApplicationController
  def create
  end

  def destroy
    offer = Offer.find(params[:id])
    # リダイレクト、値の更新用にそれぞれのidを取っておく。
    offered_proposition = offer.offered
    offering_proposition = offer.offering

    offer.destroy

    # offerの状況に合わせて案件の交換ステータスを更新
    offered_proposition.auto_update_barter_status
    offering_proposition.auto_update_barter_status

    redirect_to proposition_path(offered_proposition), success: "交換申請を取り下げました。"
  end
end
