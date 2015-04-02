class HomeController < ApplicationController
  include Calendar 

  def index
    if session[:user_id] == nil
      redirect_to login_path
    end
    display_calendar
  end

  def display_calendar
  	client
  	@calendar = get_calendar
  end
end