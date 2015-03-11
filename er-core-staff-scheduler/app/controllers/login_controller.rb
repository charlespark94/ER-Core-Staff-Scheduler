class LoginController < ApplicationController
  
  def login
  	userid = params[:username]
  	userpass = params[:userpass]
  	@user = User.find_by_username(userid)
  	if @user.id == userid && @user.pass = userpass
  	  session[:userid] = @user.userid
  	  redirect_to user_path
  	else
  	  flash[:notice] = "Invalid username and/or password"
  	  redirect_to login
  	end
  end

  def create_login
  	@user = User.create!(params[:user])
  	flash[:notice] = "Thank you creating an account. Please login in using your informaiton"
  	redirect_to login
  end

end
