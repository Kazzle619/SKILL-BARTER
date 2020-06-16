require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:follower) { create(:user) }
  let(:followed) { create(:user) }

  describe "POST #create" do
    context "未ログインの場合" do
      it "ログインが必要な旨のエラーが出ること" do
        post user_follows_path(followed.id), xhr: true
        # 非同期通信の場合、リダイレクトはされずエラーが出る。
        expect(response.status).to eq 401
      end
    end

    context "ログインしている場合" do
      before do
        sign_in follower
      end

      it "リクエストが成功すること" do
        post user_follows_path(followed.id), xhr: true
        expect(response).to have_http_status "200"
      end
      it "フォロー関係の作成に成功すること" do
        expect do
          post user_follows_path(followed.id), xhr: true
        end.to change(Follow, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:follow) { Follow.create(follower_id: follower.id, followed_id: followed.id) }

    context "未ログインの場合" do
      it "ログインが必要な旨のエラーが出ること" do
        delete user_follow_path(followed.id, follow.id), xhr: true
        # 非同期通信の場合、リダイレクトはされずエラーが出る。
        expect(response.status).to eq 401
      end
    end

    context "ログインしている場合" do
      before do
        sign_in follower
      end

      it "リクエストが成功すること" do
        delete user_follow_path(followed.id, follow.id), xhr: true
        expect(response.status).to eq 200
      end
      it "フォロー関係が削除されること" do
        expect do
          delete user_follow_path(followed.id, follow.id), xhr: true
        end.to change(follower.following_relationship, :count).by(-1)
      end
    end
  end
end
