class UsersController < ApplicationController
  skip_before_filter :check_logged_in
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.verify_email(@user).deliver
      redirect_to login_path, :notice => "Thank you for creating an account"
    else
      render "new"
    end
  end
end
