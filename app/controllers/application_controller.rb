class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :destroy_page_cache

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def destroy_page_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
  end
end
