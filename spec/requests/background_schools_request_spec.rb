require 'rails_helper'

RSpec.describe "BackgroundSchools", type: :request do
  let(:user) { create(:user) }

  describe "POST #create" do
    before do
      @background_school_params = {
        school_name: "test_school",
        school_type: "highschool",
        enrollment_status: "graduated",
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post background_schools_path, params: { background_school: @background_school_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post background_schools_path, params: { background_school: @background_school_params }
        expect(response).to have_http_status "302"
      end
      it "活動都道府県の登録が成功すること" do
        expect do
          post background_schools_path, params: { background_school: @background_school_params }
        end.to change(BackgroundSchool, :count).by(1)
      end
      it "完了ページへリダイレクトすること" do
        post background_schools_path, params: { background_school: @background_school_params }
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @background_school = BackgroundSchool.create!(
        user_id: user.id,
        school_name: "test_school",
        school_type: "highschool",
        enrollment_status: "graduated",
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete background_school_path @background_school.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete background_school_path @background_school.id
        expect(response.status).to eq 302
      end
      it "活動都道府県が削除されること" do
        expect do
          delete background_school_path @background_school.id
        end.to change(user.background_schools, :count).by(-1)
      end
      it "ユーザー編集ページへリダイレクトすること" do
        delete background_school_path @background_school.id
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end
end
