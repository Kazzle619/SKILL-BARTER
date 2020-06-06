class BackgroundJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authentticate_right_user, only: :destroy

  def create
    @new_background_job = BackgroundJob.new(background_job_params)
    @new_background_job.user_id = current_user.id
    # 入社の年、月両方入力されているときのみ有効。入力されていない場合は.saveで弾かれる。
    if @new_background_job.joining_year.present? && @new_background_job.joining_month.present?
      # フォームでは年、月だけ入力させている。日付は共通で1日にする。
      joining_date = Date.new(@new_background_job.joining_year.to_i,
                              @new_background_job.joining_month.to_i,
                              1)
      @new_background_job.joining_date = joining_date
    end

    # 入社の年、月両方入力されているときのみカラムに値を保存。どちらかでも入力されていない場合は空で保存される。
    if @new_background_job.retirement_year.present? && @new_background_job.retirement_month.present?
      # フォームでは年、月だけ入力させている。日付は共通で1日にする。
      retirement_date = Date.new(@new_background_job.retirement_year.to_i,
                                 @new_background_job.retirement_month.to_i,
                                 1)
      @new_background_job.retirement_date = retirement_date
    else
      @new_background_job.retirement_date = ""
    end

    if @new_background_job.save
      redirect_to edit_user_path(current_user.id), success: "職歴項目の追加に成功しました。"
    else
      # 要リファクタリング
      @user = current_user
      @new_skill_category = SkillCategory.new
      @new_user_prefecture = UserPrefecture.new
      @new_background_school = BackgroundSchool.new

      render 'users/edit', danger: "職歴項目の追加に失敗しました。"
    end
  end

  def destroy
    background_job = BackgroundJob.find(params[:id])
    background_job.destroy!
    redirect_to edit_user_path(current_user.id), success: "職歴項目の削除に成功しました。"
  end

  private

  def background_job_params
    params.require(:background_job).permit!
  end

  def authentticate_right_user
    background_job = BackgroundJob.find(params[:id]) if params[:id].present?
    if user_signed_in? && background_job.user != current_user
      redirect_to root_path, warning: "適切なユーザーではありません。"
    end
  end
end
