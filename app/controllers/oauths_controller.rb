class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to home_path, notice:"#{provider.titleize}アカウントでログインしました"
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end