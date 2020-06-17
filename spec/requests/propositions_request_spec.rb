require 'rails_helper'

RSpec.describe "Propositions", type: :request do
  let(:user) { create(:user) }
  let(:proposition) { build(:proposition) }
  let(:tag) { create(:tag) }

  before do
    proposition.user_id = user.id
    proposition.save!
    PropositionCategory.create(
      proposition_id: proposition.id,
      tag_id: tag.id,
    )
    RequestCategory.create(
      proposition_id: proposition.id,
      tag_id: tag.id,
    )
  end

  describe "GET #index" do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get propositions_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get propositions_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "POST #create" do
    before do
      @proposition_params = {
        user_id: user.id,
        title: Faker::Lorem.characters(number: 5),
        introduction: Faker::Lorem.characters(number: 5),
        proposition_category_tag_id: tag.id,
        request_category_tag_id: tag.id,
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post propositions_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        post propositions_path, params: { proposition: @proposition_params }
        expect(response).to have_http_status "302"
      end
      it "案件の登録が成功すること" do
        expect do
          post propositions_path, params: { proposition: @proposition_params }
        end.to change(Proposition, :count).by(1)
      end
      it "完了ページへリダイレクトすること" do
        post propositions_path, params: { proposition: @proposition_params }
        expect(response).to redirect_to finish_proposition_path Proposition.last.id
      end
    end
  end

  describe "GET #new" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get new_proposition_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get new_proposition_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_proposition_path proposition.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "案件のオーナーの場合" do
      it "リクエストが成功すること" do
        sign_in user
        get edit_proposition_path proposition.id
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        get edit_proposition_path proposition.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #show" do
    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get proposition_path proposition.id
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get proposition_path proposition.id
        expect(response).to have_http_status "200"
      end
    end

    context "案件のオーナーにブロックされている場合" do
      let(:blocked_user) { create(:user) }
      let!(:block) { Block.create(blocker_id: user.id, blocked_id: blocked_user.id) }

      # 上手く効かずCannot redirect to nil!とエラー文が出ている。
      # before { allow(request).to receive(:referer).and_return('/') }

      it "以前のページへリダイレクトすること" do
        pending "request.refererのテストの書き方が分からない。"
        sign_in blocked_user
        get proposition_path proposition.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    before do
      @proposition_params = {
        title: "test title",
        proposition_category_tag_id: tag.id,
        request_category_tag_id: tag.id,
      }
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        patch proposition_path proposition.id, proposition: @proposition_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "案件のオーナーの場合" do
      it "更新が成功すること" do
        sign_in user
        patch proposition_path proposition.id, proposition: @proposition_params
        expect(proposition.reload.title).to eq "test title"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        patch proposition_path proposition.id, proposition: @proposition_params
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @proposition = FactoryBot.build(:proposition)
      @proposition.user_id = user.id
      @proposition.save!
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete proposition_path proposition.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "案件のオーナーの場合" do
      it "案件が正常に削除されること" do
        sign_in user
        expect do
          delete proposition_path @proposition.id
        end.to change(user.propositions, :count).by(-1)
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        delete proposition_path proposition.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #mypage_index" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get mypage_index_propositions_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get mypage_index_propositions_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #offer" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get offer_propositions_path, params: { offered_id: proposition.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get offer_propositions_path, params: { offered_id: proposition.id }
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #search" do
    let(:search_params) { { title_or_introduction_cont: "test title" } }

    context "未ログインの場合" do
      it "リクエストが成功すること" do
        get search_propositions_path, params: { q: search_params }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        sign_in user
        get search_propositions_path, params: { q: search_params }
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET #finish" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get finish_proposition_path proposition.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "案件のオーナーの場合" do
      it "リクエストが成功すること" do
        sign_in user
        get finish_proposition_path proposition.id
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        get finish_proposition_path proposition.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #match" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get match_proposition_path proposition.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "案件のオーナーの場合" do
      it "リクエストが成功すること" do
        sign_in user
        get match_proposition_path proposition.id
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの場合" do
      let(:other_user) { create(:user) }

      it "トップページへリダイレクトすること" do
        sign_in other_user
        get match_proposition_path proposition.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
