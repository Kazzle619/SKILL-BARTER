require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_tag.valid? }

    let(:test_tag) { build(:tag) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'nameカラム' do
      # 適当な名前を用意
      let(:tag_name) { Faker::Lorem.characters(number: 10) }
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:another_tag) { create(:tag, name: tag_name) }

      it '空欄でないこと' do
        test_tag.name = ""
        is_expected.to eq false
      end
      it 'DBに重複がないこと' do
        test_tag.name = tag_name
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'SkillCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:skill_categories).macro).to eq :has_many
      end
    end

    context 'PropositionCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:proposition_categories).macro).to eq :has_many
      end
    end

    context 'RequestCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:request_categories).macro).to eq :has_many
      end
    end

    context 'AchievementCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:achievement_categories).macro).to eq :has_many
      end
    end
  end
end
