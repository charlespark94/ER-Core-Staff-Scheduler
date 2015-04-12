class HomeController < ApplicationController
  include Calendar 

  def index
    verify = User.find_by_id(session[:user_id]).verified
    if session[:user_id] == nil
      redirect_to login_path
    elsif !verify
      redirect_to not_verified_path
    end
  end

  # This is how you would want to call the things in calendar module. 
  # I faked the start time and end time, which the you could get from the shift models easily
  # def test
  #   dt_start = (DateTime.now.to_time).to_time
  #   dt_end = (dt_start.to_time + 5.hours).to_time
  #   gcal_event_insert(1, "david pei", "night", dt_start, dt_end)
  # end

end