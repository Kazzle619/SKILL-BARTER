require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:opponent) { create(:user) }
  let(:target) { build(:proposition) }

  before do
    target.user_id = opponent.id
    target.save!
  end

  describe "POST #create" do
    context "未ログインの場合" do
      it "ログインが必要な旨のエラーが出ること" do
        post proposition_favorites_path(target.id), xhr: true
        # 非同期通信の場合、リダイレクトはされずエラーが出る。
        expect(response.status).to eq 401
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post proposition_favorites_path(target.id), xhr: true
        expect(response).to have_http_status "200"
      end
      it "ストック関係の作成に成功すること" do
        expect do
          post proposition_favorites_path(target.id), xhr: true
        end.to change(user.favorites, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:favorite) { Favorite.create(user_id: user.id, proposition_id: target.id) }

    context "未ログインの場合" do
      it "ログインが必要な旨のエラーが出ること" do
        delete proposition_favorite_path(target.id, favorite.id), xhr: true
        # 非同期通信の場合、リダイレクトはされずエラーが出る。
        expect(response.status).to eq 401
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete proposition_favorite_path(target.id, favorite.id), xhr: true
        expect(response.status).to eq 200
      end
      it "ストック関係が削除されること" do
        expect do
          delete proposition_favorite_path(target.id, favorite.id), xhr: true
        end.to change(user.favorites, :count).by(-1)
      end
    end
  end
end
