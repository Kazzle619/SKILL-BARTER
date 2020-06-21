require 'rails_helper'

RSpec.describe "Achievements", type: :request do
  let(:user) { create(:user) }
  let(:tag) { create(:tag) }

  before do
    @achievement = Achievement.create!(
      user_id: user.id,
      title: "test achievement",
      introduction: "test achievement introduction",
    )
    @achievement_category = AchievementCategory.create!(
      achievement_id: @achievement.id,
      tag_id: tag.id,
    )
  end

  describe "GET #index" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get achievements_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "リクエストに成功する" do
        sign_in user
        get achievements_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "POST #create" do
    before do
      @achievement_params = {
        title: "test achievement",
        introduction: "test achievement introduction",
        achievement_category_tag_id: tag.id,
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post achievements_path, params: { achievement: @achievement_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post achievements_path, params: { achievement: @achievement_params }
        expect(response).to have_http_status "302"
      end
      it "案件の登録に成功すること" do
        expect do
          post achievements_path, params: { achievement: @achievement_params }
        end.to change(user.achievements, :count).by(1)
      end
      it "案件カテゴリの登録に成功すること" do
        expect do
          post achievements_path, params: { achievement: @achievement_params }
        end.to change(AchievementCategory, :count).by(1)
      end
      it "案件一覧ページへリダイレクトすること" do
        post achievements_path, params: { achievement: @achievement_params }
        expect(response).to redirect_to achievements_path
      end
    end
  end

  describe "GET #new" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get new_achievement_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "リクエストに成功する" do
        sign_in user
        get new_achievement_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_achievement_path(@achievement.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "実績のオーナーの場合" do
      it "リクエストに成功する" do
        sign_in user
        get edit_achievement_path(@achievement.id)
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        get edit_achievement_path(@achievement.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    before do
      @achievement_params = {
        title: "updated achievement",
        achievement_category_tag_id: tag.id,
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        patch achievement_path(@achievement.id), params: { achievement: @achievement_params }
      end
    end

    context "実績のオーナーの場合" do
      it "更新が成功すること" do
        sign_in user
        patch achievement_path(@achievement.id), params: { achievement: @achievement_params }
        expect(@achievement.reload.title).to eq "updated achievement"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        patch achievement_path(@achievement.id), params: { achievement: @achievement_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete achievement_path(@achievement.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "実績のオーナーの場合" do
      it "実績が正常に削除されること" do
        sign_in user
        expect do
          delete achievement_path(@achievement.id)
        end.to change(user.achievements, :count).by(-1)
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        delete achievement_path(@achievement.id)
        expect(response).to redirect_to root_path
      end
    end
  end
end
