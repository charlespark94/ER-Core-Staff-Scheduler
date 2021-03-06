class SessionsController < ApplicationController
  skip_before_filter :check_logged_in
  skip_before_filter :check_account_verified
  def new
    if session[:user_id] != nil
      redirect_to home_path and return
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if !user
      flash[:notice] = "Invalid username and/or password"
      redirect_to login_path and return
    end
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    session[:user_id] = user.id
    redirect_to home_path and return
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to login_path
  end
end
