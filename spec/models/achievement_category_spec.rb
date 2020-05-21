require 'rails_helper'

RSpec.describe AchievementCategory, type: :model do
  describe 'バリデーションのテスト' do
    # AC → achievement_category。長すぎてrubocopに弾かれるため短縮。
    subject { test_AC.valid? }

    let(:test_AC) { AchievementCategory.new(achievement_id: achievement.id, tag_id: tag.id) }
    let(:user) { create(:user) }
    let(:achievement) { create(:achievement, user_id: user.id) }
    let(:tag) { create(:tag) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'achievement_idカラム' do
      it '空欄でないこと' do
        test_AC.achievement_id = ""
        is_expected.to eq false
      end
    end

    context 'tag_idカラム' do
      it '空欄でないこと' do
        test_AC.tag_id = ""
        is_expected.to eq false
      end
    end

    context 'achievement_id, tag_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:pre_AC) { AchievementCategory.create(achievement_id: achievement.id, tag_id: tag.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'achievementモデルとの関係' do
      it 'N:1となっている' do
        expect(AchievementCategory.reflect_on_association(:achievement).macro).to eq :belongs_to
      end
    end

    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(AchievementCategory.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end
