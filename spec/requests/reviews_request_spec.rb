require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:reviewer) { create(:user) }
  let(:proposition) { build(:proposition) }
  let(:opponent) { create(:user) }
  let(:target) { build(:proposition) }
  let(:not_matched) { build(:proposition) }

  before do
    proposition.user_id = reviewer.id
    proposition.save!
    target.user_id = opponent.id
    target.save!
    not_matched.user_id = opponent.id
    not_matched.save!

    # 相互に申請を作成し、マッチ状態にしておく。
    Offer.create(
      offering_id: proposition.id,
      offered_id: target.id
    )
    Offer.create(
      offering_id: target.id,
      offered_id: proposition.id
    )
  end

  describe "GET #new" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get new_proposition_review_path(target.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "マッチング相手の場合" do
      it "リクエストが成功すること" do
        sign_in reviewer
        get new_proposition_review_path(target.id)
        expect(response).to have_http_status "200"
      end
    end

    context "マッチしていない案件の場合" do
      it "トップページへリダイレクトすること" do
        sign_in reviewer
        get new_proposition_review_path(not_matched.id)
        expect(response).to redirect_to root_path
      end
    end

    context "マッチング相手でない場合" do
      it "トップページへリダイレクトすること" do
        sign_in opponent
        get new_proposition_review_path(target.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    before do
      @review_params = {
        comment: "test review",
        rate: rand(1..5),
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post proposition_reviews_path(target.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "マッチング相手の場合" do
      before do
        sign_in reviewer
      end

      it "リクエストが成功すること" do
        post proposition_reviews_path(target.id), params: { review: @review_params }
        expect(response).to have_http_status "302"
      end
      it "レビューの登録が成功すること" do
        expect do
          post proposition_reviews_path(target.id), params: { review: @review_params }
        end.to change(Review, :count).by(1)
      end
      it "案件詳細ページへリダイレクトすること" do
        post proposition_reviews_path(target.id), params: { review: @review_params }
        expect(response).to redirect_to proposition_path(target.id)
      end
    end

    context "マッチしていない案件の場合" do
      it "トップページへリダイレクトすること" do
        sign_in reviewer
        post proposition_reviews_path(not_matched.id), params: { review: @review_params }
        expect(response).to redirect_to root_path
      end
    end

    context "マッチング相手でない場合" do
      it "トップページへリダイレクトすること" do
        sign_in opponent
        post proposition_reviews_path(target.id), params: { review: @review_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  # マッチしていなければレビューも存在しないはずなので、マッチしていない案件のテストはなし。
  describe "GET #edit" do
    before do
      @review = Review.create!(
        user_id: reviewer.id,
        proposition_id: target.id,
        comment: "test review",
        rate: rand(1..5),
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_proposition_review_path(target.id, @review.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "マッチング相手の場合" do
      it "リクエストが成功すること" do
        sign_in reviewer
        get edit_proposition_review_path(target.id, @review.id)
        expect(response).to have_http_status "200"
      end
    end

    context "マッチング相手でない場合" do
      it "トップページへリダイレクトすること" do
        sign_in opponent
        get edit_proposition_review_path(target.id, @review.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    before do
      @review = Review.create!(
        user_id: reviewer.id,
        proposition_id: target.id,
        comment: "test review",
        rate: rand(1..5),
      )
      @update_params = {
        comment: "update review",
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        patch proposition_review_path(target.id, @review.id), params: { review: @update_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "マッチング相手の場合" do
      it "更新が成功すること" do
        sign_in reviewer
        patch proposition_review_path(target.id, @review.id, review: @update_params)
        expect(target.review.reload.comment).to eq "update review"
      end
    end

    context "マッチング相手でない場合" do
      it "トップページへリダイレクトすること" do
        sign_in opponent
        patch proposition_review_path(target.id, @review.id, review: @update_params)
        expect(response).to redirect_to root_path
      end
    end
  end
end
