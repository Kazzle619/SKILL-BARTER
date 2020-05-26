class OffersController < ApplicationController
  def create
    # 値を一部入力していてrenderした時用に、ここで@new_propositionを作成。
    @proposition_id = params.to_unsafe_h.key("申請")
    @new_proposition = Proposition.new(proposition_params)
    @new_proposition.user_id = current_user.id

    # radio_numberのみ
    @offer = Offer.new(offer_params)
    # URLのparams[:proposition_id]は申請を出したい相手の案件id
    @offer.offered_id = params[:proposition_id].to_i

    # radio_numberの値で選択されていたラジオボタンを判別
    case @offer.radio_number.to_i

    # 「案件を新規に作成して申請する」が選択されていた場合
    when 1
      # まず案件、案件カテゴリ、要望カテゴリ全て必要な値が揃っているかを確認する。

      # if文の条件文に書くと長すぎるのでここで変数にする。
      is_proposition_category_selected = @new_proposition.proposition_category_tag_id.present?
      is_request_category_selected = @new_proposition.request_category_tag_id.present?

      # 案件カテゴリ, 要望カテゴリが空欄の場合はまだ案件を保存したくないので.valid?で判定。
      if @new_proposition.valid? && is_proposition_category_selected && is_request_category_selected
        # 全て揃っていることを確認してようやく案件、案件カテゴリ、要望カテゴリ、スキル交換申請を保存。
        @new_proposition.save
        PropositionCategory.create(proposition_id: @new_proposition.id,
                                   tag_id: @new_proposition.proposition_category_tag_id.to_i)
        RequestCategory.create(proposition_id: @new_proposition.id,
                               tag_id: @new_proposition.request_category_tag_id.to_i)
        # 案件を新規に作成する場合はoffering_idが空なので、ここで入れて保存。
        @offer.offering_id = @new_proposition.id
        @offer.save

        # 状況に合わせて案件の交換ステータスを更新
        @new_proposition.auto_update_barter_status

        # 完了したら案件詳細画面へ
        redirect_to proposition_path(params[:proposition_id].to_i), success: "案件の申請に成功しました。"

      # 必要なパラメータが不足している場合は申請用案件選択画面へ返す。
      else
        # renderで必要なインスタンス変数を用意。
        instance_variables_for_render
        render 'propositions/offer', danger: "スキル交換の申請に失敗しました。\n案件カテゴリ、要望カテゴリも入力されているか確認してください。"
      end

    # 「既存の案件から申請する」が選択されていた場合
    when 2
      @offer.offering_id = offering_proposition_id
      @offer.save

      # offering, offeredそれぞれの案件の交換ステータスを状況に合わせて自動更新
      @offer.offering.auto_update_barter_status
      @offer.offered.auto_update_barter_status

      # 完了したら案件詳細画面へ
      redirect_to proposition_path(params[:proposition_id].to_i), success: "案件の申請に成功しました。"

    # (UIではできないようになっているが)ラジオボタンが選択されていなかった場合
    else
      # renderで必要なインスタンス変数を用意。
      instance_variables_for_render
      render 'propositions/offer', danger: "スキル交換の申請に失敗しました。\n案件カテゴリ、要望カテゴリも必ず入力してください。"
    end
  end

  def destroy
    offer = Offer.find(params[:id])
    # リダイレクト、値の更新用にoffering, offeredそれぞれの案件インスタンスを取っておく。(どちらも値が変わる可能性がある)
    offered_proposition = offer.offered
    offering_proposition = offer.offering

    offer.destroy

    # 状況に合わせて案件の交換ステータスを自動更新
    offered_proposition.auto_update_barter_status
    offering_proposition.auto_update_barter_status

    redirect_to proposition_path(offered_proposition), success: "交換申請を取り下げました。"
  end

  private

  # 選んだラジオボタンに応じた番号がparams[:offer][:radio_number]として飛んできている。
  # 他の値は他の方法で用意するしか無かったので、ひとまずここではradio_numberのみ。
  def offer_params
    params.require(:offer).permit(:radio_number)
  end

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

  # どの既存の案件の「申請」ボタンを押したのかによってoffering_idに入れる値を判別
  # 押すボタンによって何がキーになって飛んでくるか分からないため、値が"申請"となっているキーを探す。
  def offering_proposition_id
    # 後程変更予定
    # paramsにはkeyメソッドが使えないため、一度ハッシュ化
    # 本当はpermitしてからto_hしたいが、キーが何か分からないためpermitもできないので、やむを得ずto_unsafe_hashメソッドを使用。
    params_hash = params.to_unsafe_hash
    params_hash.key("申請")
    # 上記の方法がセキュリティ上良くない、ということであれば以下の方法
    # propositions = Proposition.where(user_id: current_user.id, barter_status: "matching")
    # propositions.each do |proposition|
    #   if params[:"#{proposition.id}"] == "申請"
    #     proposition.id
    #   end
    # end
  end

  # パラメータ不足でpropositions#offerへrenderする際に必要なインスタンス変数
  def instance_variables_for_render
    @propositions = Proposition.where(user_id: current_user.id, barter_status: "matching")
    # 申請を出したい相手の案件
    @proposition = Proposition.find(params[:proposition_id])
  end
end
