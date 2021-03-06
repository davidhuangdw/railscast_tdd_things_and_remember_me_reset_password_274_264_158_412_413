class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    @user.send_password_reset if @user
    redirect_to root_url, notice:'Email sent. You can follow its instructions to reset password.'
  end
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path, notice:'Password has been reset!'
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
