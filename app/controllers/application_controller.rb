class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :destroy_page_cache

  def destroy_page_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
  end
end
