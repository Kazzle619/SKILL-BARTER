require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:proposition) { build(:proposition) }

  before do
    proposition.user_id = user.id
    proposition.save!
  end

  describe "POST #create" do
    let(:comment_params) { { content: "test_comment" } }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post proposition_comments_path(proposition.id), params: { comment: comment_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post proposition_comments_path(proposition.id), params: { comment: comment_params }
        expect(response).to have_http_status "302"
      end
      it "コメントの登録が成功すること" do
        expect do
          post proposition_comments_path(proposition.id), params: { comment: comment_params }
        end.to change(Comment, :count).by(1)
      end
      it "案件詳細ページへリダイレクトすること" do
        post proposition_comments_path(proposition.id), params: { comment: comment_params }
        expect(response).to redirect_to proposition_path(proposition.id)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @comment = Comment.create!(
        user_id: user.id,
        proposition_id: proposition.id,
        content: "test_comment"
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete proposition_comment_path(proposition.id, @comment.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "コメントが正常に削除されること" do
        sign_in user
        expect do
          delete proposition_comment_path(proposition.id, @comment.id)
        end.to change(user.comments, :count).by(-1)
      end
    end
  end
end
