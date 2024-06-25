class RoomsController < ApplicationController
  before_action :require_login

  def index
    if logged_in?
      @currentEntries = current_user.entries.includes(room: :direct_messages)
      myRoomIds = @currentEntries.map(&:room_id)
      @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id).order(created_at: :desc)
    end
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).exists?
      @direct_messages = @room.direct_messages.order(created_at: :asc)
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      # ルーム作成後にエントリーも作成
      Entry.create!(room: @room, user_id: params[:room][:user_id])
      Entry.create!(room: @room, user_id: current_user.id)
      redirect_to @room, notice: '新しいチャットルームが作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      flash.now[:notice] = 'トークルームが削除されました'
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to rooms_url }
      end
    else
      flash.now[:alert] = 'トークルームが削除できませんでした'
      respond_to do |format|
        format.turbo_stream
        format.html { render :show }
      end
    end
  end
  
  private

  def entry_params
    params.require(:entry).permit(:user_id)
  end

  def room_params
    params.require(:room).permit(:name, entries_attributes: [:user_id])
  end
end
