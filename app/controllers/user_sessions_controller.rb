class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:notice] = 'ログインしました'
      redirect_back_or_to home_path
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
