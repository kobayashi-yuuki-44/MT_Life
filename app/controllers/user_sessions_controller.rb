class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      cookies.signed[:user_id] = { value: @user.id, httponly: true, expires: 2.weeks.from_now }
      flash[:success] = t('.success')
      redirect_back_or_to home_path
    else
      flash.now[:alert] = t('.alert')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    cookies.delete(:user_id)
    flash[:success] = t('.success')
    redirect_to root_path
  end
end
