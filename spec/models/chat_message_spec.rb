require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'バリデーションのテスト' do
    # CM → chat_message。長すぎてrubocopに弾かれるため短縮。
    subject { test_CM.valid? }

    let(:test_CM) { build(:chat_message, proposition_id: proposition.id, room_id: room.id) }
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
        test_CM.proposition_id = ""
        is_expected.to eq false
      end
    end

    context 'room_idカラム' do
      it '空欄でないこと' do
        test_CM.room_id = ""
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でも良い' do
        test_CM.content = ""
        is_expected.to eq true
      end
    end

    context 'image_idカラム' do
      it '空欄でも良い' do
        test_CM.image_id = ""
        is_expected.to eq true
      end
    end

    #   DB, モデルに複合でpresence: trueのバリデーションをかけられなさそう。
    #   context 'content, image_idカラム複合' do
    #     it '空欄でないこと' do
    #       test_CM.content = ""
    #       test_CM.image_id = ""
    #       is_expected.to eq false
    #     end
    #   end
  end

  describe 'アソシエーションのテスト' do
    context 'Propositionモデルとの関係' do
      it 'N:1となっている' do
        expect(ChatMessage.reflect_on_association(:proposition).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(ChatMessage.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
