class SkillCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_aciton :authenticate_right_user, only: :destroy

  def create
    @new_skill_category = SkillCategory.new(skill_category_params)
    @new_skill_category.user_id = current_user.id
    if @new_skill_category.save
      redirect_to edit_user_path(current_user.id), success: "スキルカテゴリーの追加に成功しました。"
    else
      # 要リファクタリング
      @user = current_user
      @new_user_prefecture = UserPrefecture.new
      @new_background_school = BackgroundSchool.new
      @new_background_job = BackgroundJob.new

      render 'users/edit', danger: "スキルカテゴリーの追加に失敗しました。"
    end
  end

  def destroy
    skill_category = SkillCategory.find(params[:id])
    skill_category.destroy!
    redirect_to edit_user_path(current_user.id), success: "スキルカテゴリーの削除に成功しました。"
  end

  private

  def skill_category_params
    params.require(:skill_category).permit(:tag_id)
  end

  def authenticate_right_user
    skill_category = SkillCategory.find(params[:id]) if params[:id].present?
    if user_signed_in? && skill_category.user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
