import consumer from "consumer"

document.addEventListener('DOMContentLoaded', () => {
  let roomSubscription;

  function applyMessageStyles() {
    const currentUserId = document.body.getAttribute('data-current-user-id');
    document.querySelectorAll('.direct_message').forEach(message => {
      const isCurrentUser = message.dataset.userId == currentUserId;
      message.style.textAlign = isCurrentUser ? 'right' : 'left';

      const imageElement = message.querySelector('.profile-img-circle');
      const userNameElement = message.querySelector('.user_name');
      if (imageElement) {
        imageElement.style.float = isCurrentUser ? 'right' : 'left';
      }
      if (userNameElement) {
        userNameElement.style.textAlign = isCurrentUser ? 'right' : 'left';
      }
    });
  }

  document.addEventListener('turbo:load', () => {
    applyMessageStyles();

    const roomElement = document.getElementById('room_id');
    if (roomElement) {
      const roomId = roomElement.dataset.room_id;

      if (roomSubscription) {
        consumer.subscriptions.remove(roomSubscription);
      }

      roomSubscription = consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
        connected() {
          console.log("Connected to room " + roomId);
        },
        disconnected() {
          console.log("Disconnected from room " + roomId);
        },
        received(data) {
          console.log('Received data:', data);
          const parser = new DOMParser();
          const parsedHtml = parser.parseFromString(data.direct_message, 'text/html');
          const messageId = parsedHtml.querySelector('.direct_message').dataset.messageId;
        
          if (!document.querySelector(`[data-message-id="${messageId}"]`)) {
            const userName = parsedHtml.querySelector('.user_name').textContent;
            const messageContent = parsedHtml.querySelector('.dm_content').textContent;
            const messageTime = parsedHtml.querySelector('h7[style]').textContent;
        
            const messages = document.getElementById('messages');
            if (messages) {
              const messageElement = `
                <div data-message-id="${messageId}" class="direct_message" style="text-align: ${userName === "自分のユーザー名" ? 'right' : 'left'}">
                  <p class="user_name">${userName}</p>
                  <p class="dm_content">${messageContent}</p>
                  <p class="message_time" style="color: #C0C0C0;">${messageTime}</p>
                </div>`;
              messages.insertAdjacentHTML('beforeend', messageElement);
              applyMessageStyles();
            }
          }
        }
      });
    }

    // index.html.erb
    document.querySelectorAll('[id^="room_"]').forEach(element => {
      let roomId = element.id.split('_')[1];

      consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
        received(data) {
          let roomElement = document.querySelector(`#room_${roomId} .latest-message`);
          if (roomElement && data.latest_message) {
            roomElement.textContent = data.latest_message.message_content;
          }
        }
      });
    });
  });

  document.addEventListener('turbo:before-cache', () => {
    if (roomSubscription) {
      consumer.subscriptions.remove(roomSubscription);
      roomSubscription = null;
    }
  });
});