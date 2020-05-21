require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_achievement.valid? }

    let(:test_achievement) { build(:achievement, user_id: user.id) }
    let(:user) { create(:user) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_achievement.user_id = ""
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        test_achievement.title = ""
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        test_achievement.introduction = ""
        is_expected.to eq false
      end
    end

    context 'image_idカラム' do
      it '空欄でも良い' do
        test_achievement.image_id = ""
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Achievement.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'AchievementCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Achievement.reflect_on_association(:achievement_categories).macro).to eq :has_many
      end
    end
  end
end
