require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_review.valid? }

    let(:test_review) { build(:review, user_id: user.id, proposition_id: proposition.id) }
    let(:user) { create(:user) }
    let(:proposition) { create(:proposition, user_id: user.id) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_review.user_id = ""
        is_expected.to eq false
      end
    end

    context 'proposition_idカラム' do
      it '空欄でないこと' do
        test_review.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'commentカラム' do
      it '空欄でないこと' do
        test_review.comment = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end
  end
end
