require 'rails_helper'

RSpec.describe "Blocks", type: :request do
  let(:blocker) { create(:user) }
  let(:blocked) { create(:user) }

  describe "POST #create" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post user_blocks_path(blocked.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in blocker
      end

      it "リクエストが成功すること" do
        post user_blocks_path(blocked.id), headers: { referer: '/test' }
        expect(response).to redirect_to('/test')
      end
      it "ブロック関係の作成に成功すること" do
        expect do
          post user_blocks_path(blocked.id), headers: { referer: '/test' }
        end.to change(Block, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:block) { Block.create(blocker_id: blocker.id, blocked_id: blocked.id) }

    context "未ログインの場合" do
      it "ログインが必要な旨のエラーが出ること" do
        delete user_block_path(blocked.id, block.id), xhr: true
        # 非同期通信の場合、リダイレクトはされずエラーが出る。
        expect(response.status).to eq 401
      end
    end

    context "ログインしている場合" do
      before do
        sign_in blocker
      end

      it "リクエストが成功すること" do
        delete user_block_path(blocked.id, block.id), xhr: true
        expect(response.status).to eq 200
      end
      it "ブロック関係が削除されること" do
        expect do
          delete user_block_path(blocked.id, block.id), xhr: true
        end.to change(blocker.blocking_relationship, :count).by(-1)
      end
    end
  end
end
