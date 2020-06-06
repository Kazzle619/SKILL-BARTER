class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :index, :show]
  before_action :authenticate_right_user, except: [:top, :mypage, :index, :show]

  def top
    @users = User.all.shuffle.first(3)
    # @propositions = Proposition.all.shuffle.first(4)
    @search = Proposition.ransack(params[:q])
    @propositions = @search.result.includes(
      :proposition_category_tags,
      :request_category_tags,
    ).page(params[:page]).per(8)
  end

  def index
    @search = User.ransack(params[:q])
    # 退会していないユーザーのみ表示。
    @users = @search.result.includes(
      :skill_category_tags,
      :background_jobs,
      :background_schools,
    ).where(user_status: "subscribing").page(params[:page]).per(8)
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
    @propositions_offering_to_me_today = []
    offering_propositions_today.each do |proposition|
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
    # 要リファクタリング
    @user = User.find(params[:id])
    @new_skill_category = SkillCategory.new
    @new_user_prefecture = UserPrefecture.new
    @new_background_school = BackgroundSchool.new
    @new_background_job = BackgroundJob.new
  end

  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @follow = Follow.find_by(
        follower_id: current_user.id,
        followed_id: @user.id,
      )
    end
    @achievements = @user.achievements
    # まだマッチングしていない案件のみ表示。
    @propositions = @user.propositions.where("barter_status <= ?", 2)
    # 仕事の履歴、にはスキル交換の完了した案件を表示。
    @bartered_propositions = @user.propositions.where(barter_status: "bartered")
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(@user.id), success: "プロフィールの編集に成功しました。"
    else
      @new_skill_category = SkillCategory.new
      @new_user_prefecture = UserPrefecture.new
      @new_background_school = BackgroundSchool.new
      @new_background_job = BackgroundJob.new
      render 'users/edit', danger: "プロフィールの編集に失敗しました。"
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.update(user_status: "unsubscribed")
      sign_out user
      redirect_to root_path, success: "退会処理が完了しました。"
    else
      redirect_to edit_user_path(current_user.id), danger: "退会処理に失敗しました。\nお手数ですが、運営にご連絡ください。"
    end
  end

  def blocking
  end

  def favorites
    @propositions = current_user.favorites.map(&:proposition)
  end

  def followers
    @followers = current_user.followers.page(params[:page]).per(8).reverse_order
  end

  def following
    @following = current_user.following.page(params[:page]).per(8).reverse_order
  end

  def notice
  end

  def search
    @search = User.ransack(search_params)
    @users = @search.result.includes(
      :skill_category_tags,
      :background_jobs,
      :background_schools,
    ).where(user_status: "subscribing").page(params[:page]).per(8)
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def search_params
    params.require(:q).permit!
  end

  def authenticate_right_user
    user = User.find(params[:id])
    if user_signed_in? && user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
