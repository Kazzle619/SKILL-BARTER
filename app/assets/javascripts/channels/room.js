App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // メッセージを送ったチャットルームにだけ表示する。
    const chat_message_body = 'chat-messages-' + data['room_id']
    const $chat_messages = document.getElementById(chat_message_body);
    const user_id = document.getElementById('chat-user-id').textContent;

    if(Number(user_id) == Number(data['user_id'])){
      $chat_messages.innerHTML += data['current'];
    } else {
      $chat_messages.innerHTML += data['opponent'];
    }
  },

  speak: function(message, image, user, room) {
    return this.perform('speak', { message: message, image: image, user: user, room: room });
  }
});

document.addEventListener('DOMContentLoaded', function(){
  document.getElementById('chat-button').addEventListener('click', function(){
    const message = document.getElementById('chat-message');
    const image = document.getElementById('chat-image');
    App.room.speak(message.value, image.files[0], document.getElementById('chat-user-id').textContent, document.getElementById('chat-room-id').textContent);
    message.value = '';
    image.value = '';
  })
});
