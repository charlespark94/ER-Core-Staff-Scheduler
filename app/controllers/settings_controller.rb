class SettingsController < ApplicationController
  skip_before_filter :check_account_verified
  def new
    @user = User.find_by_id(session[:user_id])
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if params[:password].nil?
    	params[:password] = @user.password
    	params[:password_confirmation] = @user.password_confirmation
    end
    @user.update_attributes(params[:user])
    redirect_to settings_path
  end
end
