class SessionsController < ApplicationController
  def new
    if session[:user_id] != nil
      redirect_to home_path and return
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path and return
    else
      flash[:notice] = "Invalid username and/or password"
      redirect_to login_path and return
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
