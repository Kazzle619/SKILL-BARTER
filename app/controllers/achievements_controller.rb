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
      redirect_to achievements_path, success: "実績の作成に成功しました。"
    else
      @tag = Tag.new
      render 'achievements/new', danger: "実績の作成に失敗しました。"
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
      redirect_to achievements_path, success: "実績の更新に成功しました。"
    else
      @tag = Tag.new
      render 'achievements/edit', danger: "実績の更新に失敗しました。"
    end
  end

  def destroy
    achievement = Achievement.find(params[:id])
    achievement.destroy!
    redirect_to achievements_path, success: "実績の削除に成功しました。"
  end

  private

  def achievement_params
    params.require(:achievement).permit!
  end

  def authenticate_right_user
    if user_signed_in? && Achievement.find(params[:id]).user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
