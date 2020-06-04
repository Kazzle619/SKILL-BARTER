class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # コメントも画像もない場合は何も処理しない。
    if data['message'].blank? && data['image'].blank?
    else
      chat_message = ChatMessage.create!(
        content: data['message'],
        image: data['image'],
        user_id: data['user'],
        room_id: data['room'],
      )

      current_user_template = ApplicationController.render_with_signed_in_user(
        chat_message.user,
        partial: 'chat_messages/my_chat_message',
        locals: { chat_message: chat_message },
      )
      opponent_user_template = ApplicationController.render_with_signed_in_user(
        chat_message.user,
        partial: 'chat_messages/opponent_chat_message',
        locals: { chat_message: chat_message },
      )
      ActionCable.server.broadcast 'room_channel', {
        user_id: chat_message.user_id,
        room_id: data['room'],
        current: current_user_template,
        opponent: opponent_user_template,
      }
    end
  end
end
