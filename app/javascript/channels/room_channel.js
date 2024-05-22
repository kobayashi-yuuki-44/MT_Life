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

    // チャットルームへの遷移で通知をクリア
    if (window.location.pathname.includes('/rooms/') && window.location.pathname.length > '/rooms/'.length) {
      const roomId = window.location.pathname.split('/rooms/')[1];
      const notifyIcon = document.querySelector(`#room_${roomId} .notify-icon`);
      if (notifyIcon) {
        notifyIcon.style.display = 'none';
      }
    }

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
            const userNameElement = parsedHtml.querySelector('.user_name');
            const messageContentElement = parsedHtml.querySelector('.dm_content');
            const messageTimeElement = parsedHtml.querySelector('.message_time'); // クラス名を修正
            const userImage = data.user_image_url;
        
            if (userNameElement && messageContentElement && messageTimeElement) {
              const userName = userNameElement.textContent;
              const messageContent = messageContentElement.textContent;
              const messageTime = messageTimeElement.textContent;
              const currentUserId = document.body.getAttribute('data-current-user-id');
              const userId = parsedHtml.querySelector('.direct_message').dataset.userId;
              const isCurrentUser = userId === currentUserId;
        
              const messages = document.getElementById('messages');
              if (messages) {
                const messageElement = `
                <div data-message-id="${messageId}" class="direct_message flex ${isCurrentUser ? 'justify-end' : 'justify-start'} items-start my-2">
                  <div class="${isCurrentUser ? 'bubble-right bg-blue-300' : 'bubble-left bg-green-200'} flex items-center max-w-xs md:max-w-md lg:max-w-lg xl:max-w-xl px-4 py-2 rounded-lg">
                    ${isCurrentUser ? 
                      `<div class="flex flex-col mr-4">
                          <p class="whitespace-pre-line break-words dm_content mt-6">${messageContent}</p>
                          <p class="text-xs text-right text-gray-500 message_time mt-2">${messageTime}</p>
                      </div>
                      <div class="flex flex-col items-end">
                          <p class="text-sm text-gray-500 user_name">${userName}</p>
                          <img src="${userImage}" class="rounded-full w-10 h-10 object-cover mt-1">
                      </div>` :
                      `<div class="flex flex-col items-start">
                          <p class="text-sm text-gray-500 user_name">${userName}</p>
                          <img src="${userImage}" class="rounded-full w-10 h-10 object-cover mt-1">
                      </div>
                      <div class="flex flex-col ml-4">
                          <p class="whitespace-pre-line break-words dm_content mt-6">${messageContent}</p>
                          <p class="text-xs text-right text-gray-500 message_time mt-2">${messageTime}</p>
                      </div>`
                    }
                  </div>
                </div>`;
                messages.insertAdjacentHTML('beforeend', messageElement);
                applyMessageStyles();
              }
            }
          }
        }
      });
    }

    document.querySelectorAll('a[data-room-link="true"]').forEach(link => {
      link.addEventListener('click', () => {
        const roomId = link.dataset.roomId;
        const notifyIcon = document.querySelector(`#room_${roomId} .notify-icon`);
        if (notifyIcon) {
          notifyIcon.style.display = 'none';
        }
      });
    });

    // index.html.erb
    document.querySelectorAll('[id^="room_"]').forEach(element => {
      let roomId = element.id.split('_')[1];

      consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
        received(data) {
          let roomElement = document.querySelector(`#room_${roomId} .latest-message`);
          if (roomElement && data.latest_message) {
            roomElement.textContent = data.latest_message.message_content;
            
            // 通知アイコン
            let notifyIcon = document.querySelector(`#room_${roomId} .notify-icon`);
            if (notifyIcon) {
              notifyIcon.style.display = 'inline';
            }
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
