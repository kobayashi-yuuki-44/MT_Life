class DirectMessagesController < ApplicationController
  before_action :require_login

  def create
    @room = Room.find(params[:room_id])
    @direct_message = @room.direct_messages.build(direct_message_params.merge(user: current_user))

    if @direct_message.save
      DirectMessageBroadcastJob.perform_later(@direct_message)
      redirect_to room_path(@room), notice: 'メッセージが送信されました。'
    else
      redirect_to room_path(@room), alert: 'メッセージの送信に失敗しました。'
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:message_content)
  end

end
