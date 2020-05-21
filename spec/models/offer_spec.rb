require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_offer.valid? }

    let(:offer) { Offer.new(offering_id: proposition_1.id, offered_id: proposition_2.id) }
    let(:user) { create(:user) }
    let(:test_offer) { offer }
    let(:proposition_1) { create(:proposition, user_id: user.id) }
    let(:proposition_2) { create(:proposition, user_id: user.id) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'offering_idカラム' do
      it '空欄でないこと' do
        test_offer.offering_id = ""
        is_expected.to eq false
      end
    end

    context 'offered_idカラム' do
      it '空欄でないこと' do
        test_offer.offered_id = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Offeringモデルとの関係' do
      it 'N:1となっている' do
        expect(Offer.reflect_on_association(:offering).macro).to eq :belongs_to
      end
    end

    context 'Offeredモデルとの関係' do
      it 'N:1となっている' do
        expect(Offer.reflect_on_association(:offered).macro).to eq :belongs_to
      end
    end
  end

end
