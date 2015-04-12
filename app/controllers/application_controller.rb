class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :destroy_page_cache

  def destroy_page_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
  end

  def check_account_verified
  	if session[:user_id] != nil
      verify = User.find_by_id(session[:user_id]).verified
      if verify
        redirect_to home_path and return
      else
        redirect_to not_verified_path and return
      end
    end
  end
end
