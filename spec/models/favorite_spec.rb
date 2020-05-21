require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_favorite.valid? }

    let(:test_favorite) { Favorite.new(user_id: user.id, proposition_id: proposition.id) }
    let(:user) { create(:user) }
    let(:proposition) { create(:proposition, user_id: user.id) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_favorite.user_id = ""
        is_expected.to eq false
      end
    end

    context 'proposition_idカラム' do
      it '空欄でないこと' do
        test_favorite.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'user_id, proposition_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:another_favorite) { Favorite.create(user_id: user.id, proposition_id: proposition.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end
  end
end
