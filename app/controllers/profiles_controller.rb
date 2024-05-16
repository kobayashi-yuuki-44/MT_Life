class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  
  def show
    if logged_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)

      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end

        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'Profile was successfully updated.'
    else
      flash.now[:danger] = 'Failed to update the profile.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache)
  end

  def set_user
    @user = User.find(params[:user_id] || current_user.id)
  end

end
