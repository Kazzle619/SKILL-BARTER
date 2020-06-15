require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET #top" do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get root_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get root_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #index" do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get users_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get users_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #mypage" do
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

  describe "GET #edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      it "リクエストが成功すること" do
        sign_in user
        get edit_user_path user.id
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        get edit_user_path user.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #show" do
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
      let(:blocked_user) { create(:user) }
      let!(:block) { Block.create!(blocker_id: user.id, blocked_id: blocked_user.id) }

      it "リクエストが成功すること" do
        sign_in blocked_user
        get user_path user.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    let(:user_params) { { name: "test user" } }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        patch user_path user.id, user: user_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "更新が成功すること" do
        sign_in user
        patch user_path user.id, user: user_params
        expect(user.reload.name).to eq "test user"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        patch user_path user.id, user: user_params
        expect(response).to redirect_to root_path
      end
    end

    context "ゲストユーザーの場合" do
      let(:guest) { create(:guest) }

      it "トップページへリダイレクトすること" do
        sign_in guest
        patch user_path guest.id, guest: user_params
        expect(response).to redirect_to edit_user_path guest.id
      end
    end
  end

  describe "DELETE #destroy" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      before do
        sign_in user
        delete user_path user.id
      end

      it "ログアウトすること" do
        pending "user_signed_in?が使えず、ログアウトしていることのテストの書き方が分からない。"
        expect(user_signed_in?).to eq false
      end
      it "トップページへリダイレクトすること" do
        expect(response).to redirect_to root_path
      end
      it "ステータスが「退会済み」になること" do
        expect(assigns(:user).user_status).to eq "unsubscribed"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        delete user_path user.id
        expect(response).to redirect_to root_path
      end
    end

    context "ゲストユーザーの場合" do
      let(:guest) { create(:guest) }

      it "トップページへリダイレクトすること" do
        sign_in guest
        delete user_path guest.id
        expect(response).to redirect_to edit_user_path guest.id
      end
    end
  end

  describe "GET #blocking" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get blocking_user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      it "リクエストが成功すること" do
        sign_in user
        get blocking_user_path user.id
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #favorites" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get favorites_user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      it "リクエストが成功すること" do
        sign_in user
        get favorites_user_path user.id
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #followers" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get followers_user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      it "リクエストが成功すること" do
        sign_in user
        get followers_user_path user.id
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #following" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get following_user_path user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "本人の場合" do
      it "リクエストが成功すること" do
        sign_in user
        get following_user_path user.id
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #search" do
    let(:search_params) { { name_cont: Faker::Lorem.characters(number: 5) } }

    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get search_users_path, params: { q: search_params }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get search_users_path, params: { q: search_params }
        expect(response).to have_http_status "200"
      end
    end
  end
end
