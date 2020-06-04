class ChatMessagesController < ApplicationController
  def destroy
    # 非同期通信に後程変更予定。
    chat_message = ChatMessage.find(params[:id])
    chat_message.destroy!
    redirect_to request.referer
  end
end
