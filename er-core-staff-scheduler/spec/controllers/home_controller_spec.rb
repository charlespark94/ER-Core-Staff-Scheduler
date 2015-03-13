require 'spec_helper'

describe HomeController do
	it "should render index" do
		get :index, nil, {user_id: nil}
		response.should redirect_to login_path
	end
end
