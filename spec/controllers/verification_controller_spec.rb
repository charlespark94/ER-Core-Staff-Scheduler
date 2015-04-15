require 'spec_helper'

describe VerificationController do
	let(:user_params) do
			{
				id: '1',
				first_name: 'second',
				last_name: 'smith',
				usertype: 'Administrator',
				email: 'vacorescheduling@gmail.com',
				fte: '0.8',
				username: 'admin',
				password: 'admin',
				password_confirmation: 'admin',
				verified: 'true',
			}
	end
	
	it "should redirect verified" do
		@user = User.create(user_params)
		User.stub(:find_by_id).and_return(@user)
		get :index, user_params, {user_id: 1}
	end

	it "should redirect not verified" do
		@user = User.create(user_params)
		get :not, nil, {user_id: 1}
		should redirect_to(home_path)
	end

end
