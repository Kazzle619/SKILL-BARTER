require 'rails_helper'

RSpec.describe "BackgroundJobs", type: :request do
  let(:user) { create(:user) }

  describe "POST #create" do
    before do
      @background_job_params = {
        company_name: "test_company",
        joining_date: Date.today,
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post background_jobs_path, params: { background_job: @background_job_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post background_jobs_path, params: { background_job: @background_job_params }
        expect(response).to have_http_status "302"
      end
      it "職歴項目の登録が成功すること" do
        expect do
          post background_jobs_path, params: { background_job: @background_job_params }
        end.to change(BackgroundJob, :count).by(1)
      end
      it "完了ページへリダイレクトすること" do
        post background_jobs_path, params: { background_job: @background_job_params }
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @background_job = BackgroundJob.create!(
        user_id: user.id,
        company_name: "test_company",
        joining_date: Date.today,
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete background_job_path @background_job.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete background_job_path @background_job.id
        expect(response.status).to eq 302
      end
      it "職歴項目が削除されること" do
        expect do
          delete background_job_path @background_job.id
        end.to change(user.background_jobs, :count).by(-1)
      end
      it "ユーザー編集ページへリダイレクトすること" do
        delete background_job_path @background_job.id
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end
end
