class DirectMessagesController < ApplicationController
  before_action :require_login

  def create
    @room = Room.find(params[:room_id])
    @direct_message = @room.direct_messages.build(direct_message_params.merge(user: current_user))

    if @direct_message.save
      DirectMessageBroadcastJob.perform_later(@direct_message)
      notify_users_in_room(@room)
      clear_notification_for_current_user(@room) # メッセージ送信時に自分の通知をクリア
      redirect_to room_path(@room), notice: 'メッセージが送信されました。'
    else
      redirect_to room_path(@room), alert: 'メッセージの送信に失敗しました。'
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:message_content)
  end

  def notify_users_in_room(room)
    room.entries.where.not(user_id: current_user.id).each do |entry|
      entry.notify
    end
  end

  def clear_notification_for_current_user(room)
    entry = room.entries.find_by(user_id: current_user.id)
    entry.clear_notification if entry
  end
end
