require 'rails_helper'

RSpec.describe PropositionRoom, type: :model do
  describe 'バリデーションのテスト' do
    # PR → proposition_room。長すぎてrubocopに弾かれるため短縮。
    subject { test_PR.valid? }

    let(:test_PR) { PropositionRoom.new(proposition_id: proposition.id, room_id: room.id) }
    let(:user) { create(:user) }
    let(:proposition) { create(:proposition, user_id: user.id) }
    let(:room) { Room.create }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'proposition_idカラム' do
      it '空欄でないこと' do
        test_PR.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'room_idカラム' do
      it '空欄でないこと' do
        test_PR.room_id = ""
        is_expected.to eq false
      end
    end

    context 'proposition_id, room_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:pre_PR) { PropositionRoom.create(proposition_id: proposition.id, room_id: room.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(PropositionRoom.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(PropositionRoom.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
