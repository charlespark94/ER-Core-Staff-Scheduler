require 'spec_helper'

describe FteMultiplierController do
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
	
	it "should update fte mutiplier" do
		@user = User.create(user_params)
		User.stub(:find).with('1').and_return(@user)
		@user.stub(:update_attribute).and_return(true)
		get :index, {user_id: 1}
	end
		
end
