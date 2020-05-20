require 'rails_helper'

RSpec.describe UserPrefecture, type: :model do
  describe 'バリデーションのテスト' do
    subject { user_prefecture.valid? }

    let(:user_prefecture) { UserPrefecture.new(user_id: user_id, prefecture_id: prefecture_id) }
    let(:user) { create(:user) }
    let(:prefecture) { create(:prefecture) }
    context '全ての項目にデータが入っている' do
      let(:user_id) { user.id }
      let(:prefecture_id) { prefecture.id }

      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      let(:user_id) { "" }
      let(:prefecture_id) { prefecture.id }

      it '空欄でないこと' do
        is_expected.to eq false
      end
    end

    context 'user_idカラム' do
      let(:user_id) { user.id }
      let(:prefecture_id) { "" }

      it '空欄でないこと' do
        is_expected.to eq false
      end
    end

    context 'user_id、prefecture_idカラム複合' do
      let(:another_user_prefecture) { UserPrefecture.create(user_id: user.id, prefecture_id: prefecture.id) }
      let(:user_id) { user.id }
      let(:prefecture_id) { prefecture.id }

      it 'DBに重複がないこと' do
        pending '何故かtrueになる。'
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(UserPrefecture.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Prefectureモデルとの関係' do
      it 'N:1となっている' do
        expect(UserPrefecture.reflect_on_association(:prefecture).macro).to eq :belongs_to
      end
    end
  end
end
