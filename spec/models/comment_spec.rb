require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_comment.valid? }

    let(:test_comment) { build(:comment, user_id: user.id, proposition_id: proposition.id) }
    let(:user) { create(:user) }
    let(:proposition) { create(:proposition, user_id: user.id) }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_comment.user_id = ""
        is_expected.to eq false
      end
    end

    context 'proposition_idカラム' do
      it '空欄でないこと' do
        test_comment.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でも良い' do
        test_comment.content = ""
        is_expected.to eq true
      end
    end

    context 'image_idカラム' do
      it '空欄でも良い' do
        test_comment.image_id = ""
        is_expected.to eq true
      end
    end

    #   DB, モデルに複合でpresence: trueのバリデーションをかけられなさそう。
    #   context 'content, image_idカラム複合' do
    #     it '空欄でないこと' do
    #       test_comment.content = ""
    #       test_comment.image_id = ""
    #       is_expected.to eq false
    #     end
    #   end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end
  end
end
