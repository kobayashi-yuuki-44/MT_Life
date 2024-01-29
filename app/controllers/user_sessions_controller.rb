class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = t('.success')
      redirect_back_or_to home_path
    else
      flash.now[:alert] = t('.alert')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('.success')
    redirect_to root_path
  end
end
