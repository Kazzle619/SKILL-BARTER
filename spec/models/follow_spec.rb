require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_follow.valid? }

    let(:follow) { Follow.new(follower_id: user1.id, followed_id: user2.id) }
    let(:test_follow) { follow }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'follower_idカラム' do
      it '空欄でないこと' do
        test_follow.follower_id = ""
        is_expected.to eq false
      end
    end

    context 'followed_idカラム' do
      it '空欄でないこと' do
        test_follow.followed_id = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Followerモデルとの関係' do
      it 'N:1となっている' do
        expect(Follow.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end

    context 'Followedモデルとの関係' do
      it 'N:1となっている' do
        expect(Follow.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
