require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーションのテスト' do
    context 'ChatMessageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:chat_messages).macro).to eq :has_many
      end
    end

    context 'PropositionRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:proposition_rooms).macro).to eq :has_many
      end
    end
  end
end
