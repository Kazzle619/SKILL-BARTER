class BackgroundSchoolsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user, only: :destroy

  def create
    @new_background_school = BackgroundSchool.new(background_school_params)
    @new_background_school.user_id = current_user.id
    if @new_background_school.save
      flash[:success] = "学歴項目の作成に成功しました。"
      redirect_to edit_user_path(current_user.id)
    else
      # 要リファクタリング
      @user = current_user
      @new_skill_category = SkillCategory.new
      @new_user_prefecture = UserPrefecture.new
      @new_background_job = BackgroundJob.new

      render 'users/edit'
    end
  end

  def destroy
    background_school = BackgroundSchool.find(params[:id])
    background_school.destroy!
    flash[:success] = "学歴項目の削除に成功しました。"
    redirect_to edit_user_path(current_user.id)
  end

  private

  def background_school_params
    params.require(:background_school).permit!
  end

  def authenticate_right_user
    background_school = BackgroundSchool.find(params[:id]) if params[:id].present?
    if user_signed_in? && background_school.user != current_user
      flash[:warning] = "適切なユーザーではありません。"
      redirect_to root_path
    end
  end
end
