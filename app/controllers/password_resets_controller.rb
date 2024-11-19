class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :ensure_not_guest, only: %i[create update]
  
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    flash[:notice] = 'メールを送信しました。メール内の指示に従ってパスワードをリセットしてください。'
    redirect_to login_path, success: "メールを送信しました。"
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      flash[:success] = "パスワードが変更されました"
      redirect_to login_path
    else
      flash.now[:danger] = "パスワードを変更できませんでした"
      render :edit
    end
  end

  private

  def ensure_not_guest
    if current_user&.email == "guest@example.com"
      flash[:alert] = "ゲストユーザーではこの操作を行えません。"
      redirect_to root_path
    end
  end
end
