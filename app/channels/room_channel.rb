class RoomChannel < ApplicationCable::Channel
    #接続されたとき
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end
    #切断されたとき
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    DirectMessage.create! content: data['direct_message'], user_id: current_user.id, room_id: params['room_id']
  end
end
