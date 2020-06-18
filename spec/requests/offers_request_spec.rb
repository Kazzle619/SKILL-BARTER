require 'rails_helper'

RSpec.describe "Offers", type: :request do
  let(:user) { create(:user) }
  let(:offering) { build(:proposition) }
  let(:opponent) { create(:user) }
  let(:offered) { build(:proposition) }
  let(:tag) { create(:tag) }

  before do
    offering.user_id = user.id
    offering.save!
    offered.user_id = user.id
    offered.save!
  end

  describe "POST #create" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post proposition_offers_path(offered.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしており新規案件で申請する場合" do
      before do
        @proposition_params = {
          user_id: user.id,
          title: Faker::Lorem.characters(number: 5),
          introduction: Faker::Lorem.characters(number: 5),
          proposition_category_tag_id: tag.id,
          request_category_tag_id: tag.id,
        }
        sign_in user
      end

      it "リクエストが成功すること" do
        post proposition_offers_path(offered.id), params: { proposition: @proposition_params }
        expect(response).to have_http_status "302"
      end
      it "案件の登録が成功すること" do
        expect do
          post proposition_offers_path(offered.id), params: { proposition: @proposition_params }
        end.to change(user.propositions, :count).by(1)
      end
      it "申請の登録が成功すること" do
        expect do
          post proposition_offers_path(offered.id), params: { proposition: @proposition_params }
        end.to change(Offer, :count).by(1)
      end
      it "案件詳細ページへリダイレクトすること" do
        post proposition_offers_path(offered.id), params: { proposition: @proposition_params }
        expect(response).to redirect_to proposition_path(offered.id)
      end
    end

    context "ログインしており既存の案件で申請する場合" do
      let(:offering_proposition_id) { offering.id }

      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post proposition_offers_path(offered.id), params: { offering_id: offering_proposition_id }
        expect(response).to have_http_status "302"
      end
      it "申請の登録が成功すること" do
        expect do
          post proposition_offers_path(offered.id), params: { offering_id: offering_proposition_id }
        end.to change(Offer, :count).by(1)
      end
      it "案件詳細ページへリダイレクトすること" do
        post proposition_offers_path(offered.id), params: { offering_id: offering_proposition_id }
        expect(response).to redirect_to proposition_path(offered.id)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @offer = Offer.create!(
        offering_id: offering.id,
        offered_id: offered.id,
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete proposition_offer_path(offered.id, @offer.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete proposition_offer_path(offered.id, @offer.id)
        expect(response).to have_http_status "302"
      end
      it "申請が正常に削除されること" do
        expect do
          delete proposition_offer_path(offered.id, @offer.id)
        end.to change(Offer, :count).by(-1)
      end
      it "案件詳細ページへリダイレクトすること" do
        delete proposition_offer_path(offered.id, @offer.id)
        expect(response).to redirect_to proposition_path(offered.id)
      end
    end
  end
end
