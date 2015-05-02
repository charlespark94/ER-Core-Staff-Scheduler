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
      params[:user][:password] = @user.password
      params[:user][:password_confirmation] = @user.password_confirmation
    end
    if !check_password(params).nil?
      flash[:notice] = "Password and Password Confirmation must match"
      redirect_to edit_setting_path(@user) and return
    else
      @user.update_attributes(params[:user])
      flash[:notice] = "Your information has been updated"
      redirect_to settings_path and return
    end
  end

  def check_password(params)
    return false if (params[:user][:password] != params[:user][:password_confirmation])
  end
end
