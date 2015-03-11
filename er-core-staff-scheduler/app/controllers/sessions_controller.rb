class SessionsController < ApplicationController
  def new
    if cookies[:login]
      if cookies[:login] == "failed"
        flash.now.alert = "Invalid username and/or password"
      elsif cookies[:login] == "logout"
        flash.now.notice = "You have successfully logged out"
      end
      cookies.delete(:login)
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      cookies.delete(:login)
      session[:user_id] = user.id
      redirect_to home_path and return
    else
      cookies[:login] = {:value => "failed"}
      redirect_to login_path and return
    end
  end

  def destroy
    cookies[:login] = {:value => "logout"}
    session[:user_id] = nil
    redirect_to login_path
  end
end
