require 'rails_helper'

RSpec.describe RequestCategory, type: :model do
  describe 'バリデーションのテスト' do
    # RC → request_category。長すぎてrubocopに弾かれるため短縮。
    subject { test_RC.valid? }

    let(:test_RC) { RequestCategory.new(proposition_id: proposition.id, tag_id: tag.id) }
    let(:user) { create(:user) }
    let(:proposition) { create(:proposition, user_id: user.id) }
    let(:tag) { create(:tag) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'proposition_idカラム' do
      it '空欄でないこと' do
        test_RC.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'tag_idカラム' do
      it '空欄でないこと' do
        test_RC.tag_id = ""
        is_expected.to eq false
      end
    end

    context 'proposition_id, tag_idカラム複合' do
      # 重複のテストをするために、同じ値を持つデータを先に保存しておく。
      let!(:pre_RC) { RequestCategory.create(proposition_id: proposition.id, tag_id: tag.id) }

      it 'DBに重複がないこと' do
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(RequestCategory.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end

    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(RequestCategory.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end
