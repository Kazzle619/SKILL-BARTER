class UserPrefecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_right_user, only: :destroy

  def create
    @new_user_prefecture = UserPrefecture.new(user_prefecture_params)
    @new_user_prefecture.user_id = current_user.id
    if @new_user_prefecture.save
      redirect_to edit_user_path(current_user.id), success: "活動都道府県の追加に成功しました。"
    else
      # 要リファクタリング
      @user = current_user
      @new_skill_category = SkillCategory.new
      @new_background_school = BackgroundSchool.new
      @new_background_job = BackgroundJob.new

      render 'users/edit', danger: "活動都道府県の追加に失敗しました。"
    end
  end

  def destroy
    user_prefecture = UserPrefecture.find(params[:id])
    user_prefecture.destroy!
    redirect_to edit_user_path(current_user.id), success: "活動都道府県の削除に成功しました。"
  end

  private

  def user_prefecture_params
    params.require(:user_prefecture).permit(:prefecture_id)
  end

  def authenticate_right_user
    if user_signed_in? && UserPrefecture.find(params[:id]).user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
