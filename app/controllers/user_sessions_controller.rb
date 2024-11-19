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

  def guest_login
    guest_user = User.find_by(email: "guest@example.com")

    if guest_user
      auto_login(guest_user)
      cookies.signed[:user_id] = { value: guest_user.id, httponly: true, expires: 2.weeks.from_now }
      flash[:success] = "ゲストユーザーとしてログインしました。"
      redirect_to home_path
    else
      flash[:alert] = "ゲストログインに失敗しました。"
      redirect_to login_path
    end
  end
end
