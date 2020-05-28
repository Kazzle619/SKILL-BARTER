class UsersController < ApplicationController
  def top
    @users = User.all.shuffle.first(3)
    @propositions = Proposition.all.shuffle.first(4)
  end

  def index
    # 退会していないユーザーのみ表示。
    @users = User.where(user_status: "subscribing").page(params[:page]).per(8).reverse_order
  end

  # 要リファクタリング
  def mypage
    # offers_to_me_on_today = Offer.joins(
    #   "LEFT OUTER JOIN propositions ON offers.offered_id = propositions.id
    #    LEFT OUTER JOIN users ON propositions.user_id = users.id"
    # ).where(propositions: { users: { id: current_user.id } }, created_at: Time.zone.now.all_day)
    # @propositions = offers_to_me_on_today.map(&:offering)
    offers_today = Offer.where(created_at: Time.zone.now.all_day)
    offering_propositions_today = offers_today.map { |offer| offer.offering }
    offering_propositions_today.each do |proposition|
      @propositions_offering_to_me_today ||= []
      if proposition.offering.user == current_user
        @propositions_offering_to_me_today.append proposition
      end
    end

    # 長すぎてrubocopに弾かれるのでbarter_statusの判定は数字で。(5: bartered)
    @active_propositions = Proposition.where(user_id: current_user.id).where.not(barter_status: 5)
    @bartered_propositions = Proposition.where(user_id: current_user.id, barter_status: "bartered")
    @likes = @active_propositions.map { |p| p.favorites.length }.sum
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @achievements = @user.achievements
    # まだマッチングしていない案件のみ表示。
    @propositions = @user.propositions.where("barter_status <= ?", 2)
    # 仕事の履歴、にはスキル交換の完了した案件を表示。
    @bartered_propositions = @user.propositions.where(barter_status: "bartered")
  end

  def update
  end

  def destroy
  end

  def blocking
  end

  def followers
  end

  def following
  end

  def notice
  end
end
