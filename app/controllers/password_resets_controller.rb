class PasswordResetsController < ApplicationController
  def create
  	user = User.find_by_email(params[:email])
  	if user
      user.send_password_reset
  	  redirect_to login_path, :notice => "Email sent to #{user.email} with password reset instructions"
    else 
      redirect_to new_password_reset_path, :notice => "Invalid email address or we do not have that email on record"
    end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => "Password reset has expired"
  	elsif @user.update_attributes(params[:user])
  		redirect_to login_path, :notice => "Password has been reset"
  	else
  		redirect_to edit_password_reset_path @user.password_reset_token
  	end
  end
end
