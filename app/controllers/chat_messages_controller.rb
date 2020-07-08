class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_right_user

  def destroy
    # 非同期通信に後程変更予定。
    chat_message = ChatMessage.find(params[:id])
    chat_message.destroy!
    flash[:success] = "チャットメッセージの削除に成功しました。"
    redirect_to request.referer
  end

  # private

  # def authenticate_right_user
  #   chat_message = ChatMessage.find(params[:id]) if params[:id].present?
  #   if user_signed_in? && chat_message.user != current_user
  #     flash[:warning] = "適切なユーザーではありません。"
  #     redirect_to root_path
  #   end
  # end
end
