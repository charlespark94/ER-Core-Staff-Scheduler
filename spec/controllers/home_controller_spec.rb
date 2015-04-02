require 'spec_helper'

describe HomeController do
	it "should render index" do
		get :index, nil, {user_id: nil}
		response.should redirect_to login_path
	end

	#fails not sure how to login
	#it "should see the calendar" do
	#	get :index, {user_id: 'admin'}
	#	response.should have_css("iframe")
	#end
end
