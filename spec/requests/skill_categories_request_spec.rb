require 'rails_helper'

RSpec.describe "SkillCategories", type: :request do
  let(:user) { create(:user) }
  let(:tag) { create(:tag) }

  describe "POST #create" do
    let(:skill_category_params) { { tag_id: tag.id } }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        post skill_categories_path, params: { skill_category: skill_category_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "スキルカテゴリの登録が成功すること" do
        sign_in user
        expect do
          post skill_categories_path, params: { skill_category: skill_category_params }
        end.to change(user.skill_categories, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:skill_category) { SkillCategory.create!(user_id: user.id, tag_id: tag.id) }

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete skill_category_path(skill_category.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "スキルカテゴリの削除が成功すること" do
        sign_in user
        expect do
          delete skill_category_path(skill_category.id)
        end.to change(user.skill_categories, :count).by(-1)
      end
    end
  end
end
