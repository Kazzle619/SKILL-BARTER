class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_right_user, except: [:index, :create, :new]

  def index
    @achievements = Achievement.where(user_id: current_user.id)
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.achievement_category_tag_id.present? && @achievement.valid?
      @achievement.save!
      AchievementCategory.create(
        achievement_id: @achievement.id,
        tag_id: @achievement.achievement_category_tag_id.to_i
      )
      flash[:success] = "実績の作成に成功しました。"
      redirect_to achievements_path
    else
      @tag = Tag.new
      render 'achievements/new'
    end
  end

  def new
    @achievement = Achievement.new
    @tag = Tag.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
    # 今は1つしか登録できないようにしてあるのでこれで。後程変更予定。
    achievement_category = @achievement.achievement_categories[0]
    @achievement.achievement_category_tag_id = achievement_category.tag_id
    @tag = Tag.new
  end

  def update
    @achievement = Achievement.find(params[:id])
    achievement_category_tag_id = params[:achievement][:achievement_category_tag_id]
    if achievement_category_tag_id.present? && @achievement.update(achievement_params)
      @achievement.achievement_categories[0].update(tag_id: achievement_category_tag_id)
      flash[:success] = "実績の更新に成功しました。"
      redirect_to achievements_path
    else
      @tag = Tag.new
      render 'achievements/edit'
    end
  end

  def destroy
    achievement = Achievement.find(params[:id])
    achievement.destroy!
    flash[:success] = "実績の削除に成功しました。"
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit!
  end

  def authenticate_right_user
    achievement = Achievement.find(params[:id]) if params[:id].present?
    if user_signed_in? && achievement.user != current_user
      flash[:warning] = "適切なユーザーではありません。"
      redirect_to root_path
    end
  end
end
