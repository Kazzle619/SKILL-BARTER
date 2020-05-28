class UsersController < ApplicationController
  def top
    @users = User.all.shuffle.first(3)
    @propositions = Proposition.all.shuffle.first(4)
  end

  def index
    # 退会していないユーザーのみ表示。
    @users = User.where(user_status: "subscribing").page(params[:page]).per(8).reverse_order
  end

  def mypage
    @user = current_user
    # offers_to_me_on_today = Offer.joins(
    #   "LEFT OUTER JOIN propositions ON offers.offered_id = propositions.id
    #    LEFT OUTER JOIN users ON propositions.user_id = users.id"
    # ).where(propositions: { users: { id: current_user.id } }, created_at: Time.zone.now.all_day)
    # @propositions = offers_to_me_on_today.map(&:offering)
    @propositions = Proposition.joins(:user).where(users: { id: current_user.id })
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
