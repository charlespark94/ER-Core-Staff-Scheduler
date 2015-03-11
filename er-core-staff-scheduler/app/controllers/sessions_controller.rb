class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url and return
    else
      flash.now.alert = "Invalid username and/or password"
      redirect_to login_path and return
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => "Logged out" and return
  end
end
