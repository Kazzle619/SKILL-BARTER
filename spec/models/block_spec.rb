require 'rails_helper'

RSpec.describe Block, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_block.valid? }

    let(:block) { Block.new(blocker_id: user1.id, blocked_id: user2.id) }
    let(:test_block) { block }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'blocker_idカラム' do
      it '空欄でないこと' do
        test_block.blocker_id = ""
        is_expected.to eq false
      end
    end

    context 'blocked_idカラム' do
      it '空欄でないこと' do
        test_block.blocked_id = ""
        is_expected.to eq false
      end
    end

    context 'blocker_id, blocked_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:another_block) { Block.create(blocker_id: user1.id, blocked_id: user2.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Blockerモデルとの関係' do
      it 'N:1となっている' do
        expect(Block.reflect_on_association(:blocker).macro).to eq :belongs_to
      end
    end

    context 'Blockedモデルとの関係' do
      it 'N:1となっている' do
        expect(Block.reflect_on_association(:blocked).macro).to eq :belongs_to
      end
    end
  end
end
