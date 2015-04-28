class SettingsController < ApplicationController
  skip_before_filter :check_account_verified
  def index
    @user = User.find_by_id(session[:user_id])
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if params[:user][:password] == ""
    	params[:password] = @user.password
    	params[:password_confirmation] = @user.password_confirmation
    elsif params[:user][:password] != params[:user][:password_confirmation]
    	flash[:notice] = "Password and Password Confirmation must match"
    	redirect_to edit_setting_path(@user) and return
    end
    @user.update_attributes(params[:user])
    flash[:notice] = "Your information has been updated"
    redirect_to settings_path
  end
end
