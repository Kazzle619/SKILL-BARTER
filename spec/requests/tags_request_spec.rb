require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "POST #create" do
    let(:tag_params) { { name: "test tag" } }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post tag_path, params: tag_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      let(:user) { create(:user) }

      it "案件の登録が成功すること" do
        pending "request.refererのテストの書き方が分からない。"
        sign_in user
        expect do
          post tag_path, params: tag_params
        end.to change(Tag, :count).by(1)
      end
    end
  end
end
