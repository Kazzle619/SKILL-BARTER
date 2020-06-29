require 'rails_helper'

RSpec.describe "ChatMessages", type: :request do
  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:room) { Room.create! }

    before do
      @chat_message = ChatMessage.create!(
        user_id: user.id,
        room_id: room.id,
        content: "test chat message",
      )
    end

    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        delete chat_message_path(@chat_message.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      it "チャットメッセージが正常に削除されること" do
        sign_in user
        expect do
          delete chat_message_path(@chat_message.id), headers: { referer: '/test' }
        end.to change(user.chat_messages, :count).by(-1)
      end
    end
  end
end
