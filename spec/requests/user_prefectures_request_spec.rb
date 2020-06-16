require 'rails_helper'

RSpec.describe "UserPrefectures", type: :request do
  let(:user) { create(:user) }
  let(:prefecture) { create(:prefecture) }

  describe "POST #create" do
    before do
      @user_prefecture_params = { prefecture_id: prefecture.id }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post user_prefectures_path, params: { user_prefecture: @user_prefecture_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post user_prefectures_path, params: { user_prefecture: @user_prefecture_params }
        expect(response).to have_http_status "302"
      end
      it "活動都道府県の登録が成功すること" do
        expect do
          post user_prefectures_path, params: { user_prefecture: @user_prefecture_params }
        end.to change(UserPrefecture, :count).by(1)
      end
      it "完了ページへリダイレクトすること" do
        post user_prefectures_path, params: { user_prefecture: @user_prefecture_params }
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user_prefecture) { UserPrefecture.create(user_id: user.id, prefecture_id: prefecture.id) }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete user_prefecture_path user_prefecture.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete user_prefecture_path user_prefecture.id
        expect(response.status).to eq 302
      end
      it "活動都道府県が削除されること" do
        expect do
          delete user_prefecture_path user_prefecture.id
        end.to change(user.user_prefectures, :count).by(-1)
      end
      it "ユーザー編集ページへリダイレクトすること" do
        delete user_prefecture_path user_prefecture.id
        expect(response).to redirect_to edit_user_path user.id
      end
    end
  end
end
