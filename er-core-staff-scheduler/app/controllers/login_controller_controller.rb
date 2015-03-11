class LoginControllerController < ApplicationController
  
  def login
  	userid = params[:username]
  	userpass = params[:userpass]
  	@user = User.find_by_username(userid)
  	if @user.id == userid && @user.pass = userpass
  	  session[:usertype] = @user.usertype
  	  redirect_to user_path
  	else
  	  flash[:notice] = "Invalid username and/or password"
  	  redirect_to login
  end

  def create
  	@user = User.create!(params[:user])
  	flash[:notice] = "Thank you creating an account. Please login in using your informaiton"
  	redirect_to login
  end

end
