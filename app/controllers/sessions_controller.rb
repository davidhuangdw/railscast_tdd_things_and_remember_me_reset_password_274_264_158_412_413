class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # session[:user_id] = user.id
      ck = params[:remember_me] ? cookies.permanent : cookies
      ck[:auth_token] = user.auth_token
      redirect_to root_url, notice: 'Logged in successfully.'
    else
      flash.now.alert = 'Invalid email address or password.'
      render 'new'
    end
  end

  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url, notice: 'Logged out!'
  end

end
