class BackgroundSchoolsController < ApplicationController
  def create
    @new_background_school = BackgroundSchool.new(background_school_params)
    @new_background_school.user_id = current_user.id
    if @new_background_school.save
      redirect_to edit_user_path(current_user.id), success: "学歴項目の作成に成功しました。"
    else
      # 要リファクタリング
      @user = current_user
      @new_skill_category = SkillCategory.new
      @new_user_prefecture = UserPrefecture.new
      @new_background_job = BackgroundJob.new

      render 'users/edit', danger: "学歴項目の作成に失敗しました。"
    end
  end

  def destroy
    background_school = BackgroundSchool.find(params[:id])
    background_school.destroy!
    redirect_to edit_user_path(current_user.id), success: "学歴項目の削除に成功しました。"
  end

  private

  def background_school_params
    params.require(:background_school).permit(:school_name,
                                              :school_type,
                                              :department,
                                              :enrollment_status)
  end
end
