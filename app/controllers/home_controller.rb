class HomeController < ApplicationController
  include Calendar 

  def index
    if session[:user_id] == nil
      redirect_to login_path
    end
    test
  end

  def test
    dt_start = (DateTime.now.to_time - 7).to_time
    dt_end = (dt_start.to_time + 5).to_time
    gcal_event_insert(1, "david pei", "night", dt_start, dt_end, "confirmed")
  end

end