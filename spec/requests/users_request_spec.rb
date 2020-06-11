require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #top' do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get root_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      let(:user) { create(:user) }

      it "リクエストが成功すること" do
        sign_in user
        get root_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe 'GET #index' do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get users_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      let(:user) { create(:user) }

      it "リクエストが成功すること" do
        sign_in user
        get users_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe 'GET #mypage' do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get mypage_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      let(:user) { create(:user) }

      it "リクエストが成功すること" do
        sign_in user
        get mypage_users_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe 'GET #edit' do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_user_path 1
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      let(:user) { create(:user) }

      it "リクエストが成功すること" do
        sign_in user
        get edit_user_path user.id
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in user2
        get edit_user_path user.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get user_path user.id
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get user_path user.id
        expect(response).to have_http_status "200"
      end
    end

    context "ブロックされている場合" do
      let(:user2) { create(:user) }
      let(:block) { Block.create!(blocker_id: user.id, blocked_id: user2.id) }

      it "リクエストが成功すること" do
        sign_in user2
        get user_path user.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
