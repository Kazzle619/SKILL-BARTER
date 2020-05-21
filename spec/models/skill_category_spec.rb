require 'rails_helper'

RSpec.describe SkillCategory, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_skill_category.valid? }

    let(:test_skill_category) { SkillCategory.new(user_id: user.id, tag_id: tag.id) }
    let(:user) { create(:user) }
    let(:tag) { create(:tag) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_skill_category.user_id = ""
        is_expected.to eq false
      end
    end

    context 'tag_idカラム' do
      it '空欄でないこと' do
        test_skill_category.tag_id = ""
        is_expected.to eq false
      end
    end

    context 'user_id, tag_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:another_skill_category) { SkillCategory.create(user_id: user.id, tag_id: tag.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(SkillCategory.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(SkillCategory.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end
